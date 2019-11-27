class TagAssociation < ApplicationRecord
    belongs_to :tag, :counter_cache => true
    belongs_to :task
end
