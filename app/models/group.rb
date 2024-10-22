class Group < ApplicationRecord
  has_and_belongs_to_many :users, optional: true
  has_many :messages, dependent: :nullify
end
