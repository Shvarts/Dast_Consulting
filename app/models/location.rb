class Location < ActiveRecord::Base
  acts_as_gmappable :process_geocoding => true
  attr_accessible :address, :gmaps, :latitude, :longitude, :owner_email, :zip
  def gmaps4rails_address
  	address
  end
  def gmaps4rails_infowindow
    "<h4>#{address}</h4>" << "<h4>#{zip}<h4>"
  end
  Location.instance_eval do
    def process_geocoding
      true
    end
  end
  def gmaps4rails_sidebar
    address
  end
end
