class User < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :tasks, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true

  auto_strip_attributes :username, :email, squish: true
end
