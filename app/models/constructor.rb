class Constructor < ActiveRecord::Base
  has_many :drivers
  has_many :events, through: :races
  has_many :events, through: :qualis
  has_many :races
  has_many :qualis

  # Remember to include all these attributes on the
  # client side application (eg. don't let nationality blank)
  validates :name, presence: true
  validates :nationality, presence: true
  validates :n_champion, presence: true
  validates :constructorId, presence: true
  validates :position, presence: true

  # ADMIN methods
  def self.add_new_constructor(constructor, driver1, driver2)
    transaction do
      tDriver1 = Driver.find_by(id: driver1[:id])
      tDriver2 = Driver.find_by(id: driver2[:id])
      tDriver2.constructor = constructor
      tDriver1.constructor = constructor
      tDriver1.save
      tDriver2.save
    end
  end

  def self.update_c(constructor, driver1, driver2)
    transaction do
      tempContructor = Constructor.find_by(id: constructor[:id])
      tempContructor.name = constructor[:name]
      tempContructor.constructorId = constructor[:constructorId]
      tempContructor.nationality = constructor[:nationality]
      tempContructor.position = constructor[:position]
      tempContructor.n_champion = constructor[:n_champion]
      tempContructor.engine = constructor[:engine]
      tempContructor.chassis = constructor[:chassis]
      tempContructor.car_name = constructor[:car_name]
      tempContructor.save

      if driver1
        tDriver1 = Driver.find_by(id: driver1[:id])
        tDriver1.constructor = tempContructor
        tDriver1.save
      end

      if driver2
        tDriver2 = Driver.find_by(id: driver2[:id])
        tDriver2.constructor = tempContructor
        tDriver2.save
      end
    end
  end

  # API methods
  def self.simple_constructor_standing
    constructors = Constructor.all;
    constructors.each do |constructor|
      constructor.points = 0
      constructor.drivers.each do |driver|
        constructor.points = constructor.points + driver.points
      end
    end
    constructors
  end
end
