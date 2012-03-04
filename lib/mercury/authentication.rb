module Mercury
  module Authentication

    def can_edit?
      current_user # check if user is logged in
    end
  end
end