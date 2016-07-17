class Event < ActiveRecord::Base
  has_many :constructors, through: :races
  has_many :constructors, through: :qualis
  has_many :drivers, through: :races
  has_many :drivers, through: :qualis
  has_many :qualis
  has_many :races

  validates :name, presence: true
  validates :nation, presence: true
  validates :city, presence: true
  
  attr_accessor :total_points
end
