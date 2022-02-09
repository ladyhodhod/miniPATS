class Pet < ApplicationRecord

  # Relationships
   belongs_to :owner
   belongs_to :animal
   has_many :visits


  # Scopes
  # -----------------------------
  # order pets by their name
  scope :alphabetical, -> { order('name') }
  # get all the pets we treat (not moved away or dead)
  scope :active, -> { where(active: true) }
  # get all the pets we heave treated that moved away or died
  scope :inactive, -> { where.not(active: true) }
  # alternative ways of doing the inactive scope:
  # scope :inactive, -> { where(active: false) }
  # scope :inactive, -> { where('active = ?', true) }
  # get all the female pets
  scope :females, -> { where(female: true) }
  # get all the male pets
  scope :males, -> {where(female: false) }
  # or 
  # scope :males, -> { where.not(female: true) }

  # get all the pets for a particular owner
  scope :for_owner, ->(owner_id) { where("owner_id = ?", owner_id) }
  # get all the pets who are a particular animal type
  scope :by_animal, ->(animal_id) { where("animal_id = ?", animal_id) }
  # get all the pets born before a certain date
  scope :born_before, ->(dob) { where('date_of_birth < ?', dob) }

  # find all pets that have a name like some term or are and animal like some term
  scope :search, ->(term) { joins(:animal).where('pets.name LIKE ?', "#{term}%").order("pets.name") }

end
