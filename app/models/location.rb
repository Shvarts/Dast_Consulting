class Location < ActiveRecord::Base
  acts_as_gmappable :process_geocoding => true
  attr_accessible :address, :gmaps, :latitude, :longitude, :owner_email, :zip, :description, :parcelNumber_Value,  :altParcelNumber_Value, :name_Value, :name2_Value, :grossLandValue_Value, :grossImprovementValue_Value, :grossAssessedValue_Value, :neighborhoodName_Value, :propertyClass_Value, :propertySubClass_Value, :taxYear_Value, :yrConstructed_Value, :fullBaths_Value, :halfBaths_Value, :bedrooms_Value, :improvementType_Value
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

  def self.search(search)
    if search
      where('address LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
