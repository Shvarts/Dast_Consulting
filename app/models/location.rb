class Location < ActiveRecord::Base
  attr_accessible :address, :gmaps, :latitude, :longitude, :owner_email, :zip
end
