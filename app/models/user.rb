class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :api

  validates :password_confirmation, presence: true, on: :create

  has_and_belongs_to_many :groups
  has_many :messages, dependent: :destroy
end
