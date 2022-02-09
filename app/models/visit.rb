class Visit < ApplicationRecord

  # Relationships
  belongs_to :pet

  # Scopes
  # -----------------------------
  # by default, order by visits in descending order (most recent first)
   scope :chronological, lambda { order('date DESC') }
   # get all the visits by a particular pet (using the 'stabby lambda' notation here)
   scope :for_pet, ->(pet_id) { where('pet_id = ?', pet_id) }
   # get the last X visits (using the 'stabby lambda' notation here)
   scope :last_x, ->(num) { limit(num).order('date DESC') }

end
