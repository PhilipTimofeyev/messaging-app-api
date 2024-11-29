class Group < ApplicationRecord
  has_and_belongs_to_many :users, optional: true
  has_many :messages, dependent: :nullify

    def add_users(users)
      users_arr = users.to_h.values.map(&:to_i)
      users_arr.each do |user_id|
        user = User.find(user_id)
        self.users << user
      end
    end

    def add_message(message_id)
      message = Message.find(message_id)
      self.messages << message
    end

    def get_group_messages_with_images
      self.messages.order(:created_at).map do |message|
        message.as_json.merge(image: message.image_url)
      end
    end
end
