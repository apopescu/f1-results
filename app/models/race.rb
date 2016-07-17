class Race < ActiveRecord::Base
  belongs_to :constructor
  belongs_to :event
  belongs_to :driver

  validates :position, presence: true
  validates :grid, presence: true
  validates :time, presence: true
  validates :status, presence: true

  attr_accessor :round

  def self.add_new_results(event, results)
  	transaction do
		results.each do |resultItem|
			raceResult = resultItem.except(:driver, :tyres)
			tyres = ""
			resultItem[:tyres].each do |key, value|
				if(value > 0)
					tyres = tyres + (key + " ")*value
				end
			end
			driver = Driver.find_by(id: resultItem[:driver][:id])
			race = Race.new(raceResult)
			
			
			# Race information
			race.event = event
			race.constructor = driver.constructor
			race.driver = driver
			race.tyres = tyres
			race.save


			# Updates constructors/drivers points
	  		drivers = Driver.all
			drivers.each do |driver|
				driver.points = 0
  				driver.races.each do |race|
  					driver.points = driver.points + race.points
  				end
  				driver.save
			end

			constructors = Constructor.all
			constructors.each do |constructor|
				constructor.points = 0
				constructor.races.where(constructor_id: constructor.id).each do |race|
					constructor.points = constructor.points + race.points
				end
				constructor.save
			end
		end
	end
  end
  

  def self.update_race(event, results)
  	transaction do
  		results.each do |resultItem|
  			raceResult = resultItem.except(:driver, :tyres)
  			tyres = ""
			resultItem[:tyres].each do |key, value|
				if(value > 0)
					tyres = tyres + (key + " ")*value
				end
			end
			driver = Driver.find_by(id: resultItem[:driver][:id])
			race = event.races.find_by(id: resultItem[:id])

			race.update_attributes(raceResult)
			race.tyres = tyres
			race.driver = driver
			race.constructor = driver.constructor
			race.save

			# Updates drivers points
		  	drivers = Driver.all
			drivers.each do |driver|
				driver.points = 0
  				driver.races.each do |race|
  					driver.points = driver.points + race.points
  				end
  				driver.save
  			end

  			# Updates constructors points
  			constructors = Constructor.all
  			constructors.each do |constructor|
  				constructor.points = 0
  				constructor.races.where(constructor_id: constructor.id).each do |race|
  					constructor.points = constructor.points + race.points
  				end
  				constructor.save
  			end
  		end
  	end
  end
end
