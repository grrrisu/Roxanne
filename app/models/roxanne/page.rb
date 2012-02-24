module Roxanne
  class Page < ActiveRecord::Base
    include Sortable

    has_many :containers, :dependent => :destroy
    has_ancestry :cache_depth => true, :depth_cache_column => :depth

    before_validation :set_layout
    before_save :set_uri

    validates :title, :presence => true, :uniqueness => {:scope => :ancestry}
    validates :layout, :presence => true

    def self.root
      roots.first
    end

    def sorted_subtree(depth = nil)
      nodes = depth ? subtree(:to_depth => depth) : subtree
      Page.sort_by_ancestry(nodes, :sort)
    end

    def set_layout
      self.layout = layout.present? ? layout.to_sym : :application
    end

    def set_uri
      if parent_id
        parent_page = Page.unscoped.find(parent_id)
        ancestors = parent_page.ancestors                 # [root, first_level]
        ancestors_and_parent = ancestors << parent_page   # [root, first_level, parent]
        ancestors.shift                                   # remove root -> [first_level, parent]
        uri = (ancestors_and_parent << self).map(&:title).join('/') # first_level.title/parent.title/self.title
      else
        uri = ''
      end
      # TODO can friendly_uri help here?
      self.uri = uri.gsub(' ', '_')
    end

    def url
      "/#{uri}"
    end

    # TODO fork ancestry and replace this method in ancestry / lib / ancestry / class_methods.rb
    # Pseudo-preordered array of nodes.  Children will always follow parents,
    # for ordering nodes within a rank use the an attribute
    def self.sort_by_ancestry(nodes, sorting_attribute = nil)
      arranged = if nodes.is_a?(Hash)
        nodes
      else
        nodes = nodes.sort_by do |n|
          "#{n.ancestry}-#{n.send(sorting_attribute) if sorting_attribute}" || '0'
        end
        arrange_nodes(nodes)
      end
      arranged.inject([]) do |sorted_nodes, pair|
        node, children = pair
        sorted_nodes << node
        sorted_nodes += sort_by_ancestry(children, sorting_attribute) unless children.blank?
        sorted_nodes
      end
    end
    
  end
end