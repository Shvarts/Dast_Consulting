class AddDetailsToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :parcelNumber_Value, :integer
    add_column :locations, :altParcelNumber_Value, :string
    add_column :locations, :name_Value, :string
    add_column :locations, :name2_Value, :string
    add_column :locations, :grossLandValue_Value, :integer
    add_column :locations, :grossImprovementValue_Value, :integer
    add_column :locations, :grossAssessedValue_Value, :integer
    add_column :locations, :neighborhoodName_Value, :string
    add_column :locations, :propertyClass_Value, :string
    add_column :locations, :propertySubClass_Value, :string
    add_column :locations, :taxYear_Value, :integer
    add_column :locations, :yrConstructed_Value, :integer
    add_column :locations, :fullBaths_Value, :integer
    add_column :locations, :halfBaths_Value, :integer
    add_column :locations, :bedrooms_Value, :integer
    add_column :locations, :improvementType_Value, :string
  end
end
