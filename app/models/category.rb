class Category < ApplicationRecord
    belongs_to :user
    has_many :tasks, dependent: :destroy

    auto_strip_attributes :title, squish: true
end
