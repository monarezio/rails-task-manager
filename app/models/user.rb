class User < ApplicationRecord
  has_many :categories
  has_many :tags
  has_many :tasks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  auto_strip_attributes :username, :email, squish: true
end
