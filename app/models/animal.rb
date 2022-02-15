class Animal < ApplicationRecord

    # Callbacks
    # -----------------------------
    # Callback - to prevent animal deletion
    before_destroy :cannot_destroy_animal
    
    # Relationships
    # -----------------------------
    has_many :pets

     # Scopes
     # -----------------------------
     scope :alphabetical, -> { order('name') }
     scope :active,       -> { where(active: true) }
     scope :inactive,     -> { where(active: false) }

    # Validations
    # -----------------------------
    validates_presence_of :name # name cannot be blank!
    validates :name, uniqueness: true
    # Or
    validates_uniqueness_of :name, message:"Animal already in the records"
    
    # Make sure that all Animal names start witha  capital letter
    validates_format_of :name, with: /\A[A-Z]/, message:"Name should start with Capital letter"

    # Make sure the animal name contains more than 2 letters 
    validates :name, length:{ minimum: 2}

    # Private methods for custom validations and callback handlers
    # -----------------------------
    private 
    # Callback handler to prevent animal deletions
    def cannot_destroy_animal
    msg = "This animal cannot be deleted at this time. If this is a mistake, please alert the administrator."
    errors.add(:base, msg)
    throw(:abort) if errors.present?
    end

end
  