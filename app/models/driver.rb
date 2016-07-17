class Driver < ActiveRecord::Base
  belongs_to :constructor
  has_many :events, through: :races
  has_many :events, through: :qualis
  has_many :races
  has_many :qualis

  # Remember to include all these attributes on the
  # client side application
  validates :role, presence: true
  validates :givenName, presence: true
  validates :familyName, presence: true
  validates :nationality, presence: true
  validates :dob, presence: true
  validates :position, presence: true
  validates :number, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 150 }
end
