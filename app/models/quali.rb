class Quali < ActiveRecord::Base
  belongs_to :constructor
  belongs_to :event
  belongs_to :driver

  validates :position, presence: true

  def self.add_new_results(event, results)
  	transaction do
		results.each do |resultItem|
			qualiResult = resultItem.except(:driver, :tyres)
			tyres = ""
			resultItem[:tyres].each do |key, value|
				if(value > 0)
					tyres = tyres + (key + " ")*value
				end
			end
			quali = Quali.new(qualiResult)
			quali.tyres = tyres
			driver = Driver.find_by(id: resultItem[:driver][:id])
			quali.event = event
			quali.driver = driver
			quali.constructor = driver.constructor
			quali.save
		end
	end
  end

  def self.update_quali(event, results)
  	transaction do
  		results.each do |resultItem|
  			qualiResult = resultItem.except(:driver, :tyres)
  			tyres = ""
			resultItem[:tyres].each do |key, value|
				if(value > 0)
					tyres = tyres + (key + " ")*value
				end
			end
			quali = event.qualis.where(id: resultItem[:id]).first
			quali.update_attributes(qualiResult)
			quali.tyres = tyres
			driver = Driver.find_by(id: resultItem[:driver][:id])
			quali.driver = driver
			quali.constructor = driver.constructor

			quali.save
  		end
  	end
  end
end
