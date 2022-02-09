class Animal < ApplicationRecord
    # Relationships
    has_many :pets

    # Scopes
    scope :alphabetical, -> { order('name') }
    scope :active,       -> { where(active: true) }
    scope :inactive,     -> { where(active: false) }

    
end
  