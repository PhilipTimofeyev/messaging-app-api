class Group < ApplicationRecord
  has_and_belongs_to_many :users, optional: true
  has_many :messages, dependent: :nullify

    # scope :get_single_group,
    # ->(current_user_id, selected_user_id) do
    #   includes(:users).select do |group|
    #       group.users.exists?(current_user_id) &&
    #       group.users.exists?(selected_user_id) &&
    #       group.users.count == 2
    #   end
    # end

    def add_users(users)
      users.each do |user_id|
        user = User.find(user_id)
        self.users << user
      end
    end

    def add_message(message_id)
      message = Message.find(message_id)
      self.messages << message
    end
end
