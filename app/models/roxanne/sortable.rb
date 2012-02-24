module Roxanne
  module Sortable
    extend ActiveSupport::Concern

    included do

      attr_reader :sibling, :sibling_id

      before_validation :set_sort
      before_save :shift_sibling_sorting

      validates :sort, :presence => true

      scope :sorted, order('sort ASC')

    end

    module InstanceMethods
    
      def sibling_id= id
        if id.present?
          @sibling_id = id
          @sibling    = self.class.base_class.find(id)
          self.parent = @sibling.parent
          self.sort   = @sibling.sort
        end
      end

      def set_sort
        self.sort = siblings.count if sort.blank?
      end
    
      def shift_sibling_sorting
        if sibling_id.present?
          self.class.base_class.children_of(parent).where('sort >= ?', sort).update_all('sort = sort+1')
        end
      end

    end

  end
end