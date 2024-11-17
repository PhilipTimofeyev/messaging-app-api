class Message < ApplicationRecord
  belongs_to :group, optional: true
  belongs_to :user
  has_one_attached :image
end
