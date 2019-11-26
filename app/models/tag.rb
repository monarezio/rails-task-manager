class Tag < ApplicationRecord
    belongs_to :user

    has_many :tag_associations, dependent: :destroy
    has_many :tasks, through: :tag_associations

    auto_strip_attributes :title, squish: true
end
