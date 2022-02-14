class Visit < ApplicationRecord

  # Callbacks
  # -----------------------------
  # Callback - to prevent visit deletions
  before_destroy :cannot_destroy_visit

  # Relationships
  # -----------------------------
  belongs_to :pet
  has_one :animal, through: :pet
  has_one :owner, through: :pet

  # Scopes
  # -----------------------------
  # by default, order by visits in descending order (most recent first)
   scope :chronological, lambda { order('date DESC') }
   # get all the visits by a particular pet (using the 'stabby lambda' notation here)
   scope :for_pet, ->(pet_id) { where('pet_id = ?', pet_id) }
   # get the last X visits (using the 'stabby lambda' notation here)
   scope :last_x, ->(num) { limit(num).order('date DESC') }

   # Validations
  # -----------------------------
  # old style validation for presence_of pet_id b/c only validation for that attribute
  validates_presence_of :pet_id

  # date must be a valid date
  # validates_date is available from the validate_timeliness gem. This is not a default ActiveRecord helper
  validates_date :date

  # weight must be present and a number greater than 0 and less than 100 (none of our animal types will exceed)
  validates :weight, presence: true, numericality: { greater_than: 0, less_than: 100 }

  # Private methods for custom validations and callback handlers
  # -----------------------------
  private 
  # Callback handler to prevent visit deletions
  def cannot_destroy_visit
    msg = "This visit cannot be deleted at this time. If this is a mistake, please alert the administrator."
    errors.add(:base, msg)
    throw(:abort) if errors.present?
  end

end
