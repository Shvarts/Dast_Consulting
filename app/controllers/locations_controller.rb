class LocationsController < ApplicationController
  before_filter :authenticate#, :except => [:index, :show]
  respond_to :json, :html

  # GET /locations
  # GET /locations.json
  def index
    puts "____-----------------------------index_____________"
      @locals = Location.all
    @locs = []

    @locals.each do |l| 
      if l.owner_email.index(current_user.email)
        @locs << l
      end
    end
    
    @search = params[:search]
    @locations = []
    @locs.each do |l|
      if l.address.index(@search.to_s) && @search !="" && @search !=nil
        @locations<<l
      end
    end
    if @locations.empty?
      @locations = @locs
    end
  end

  def show_location_on_map
      @locs = Location.where(:owner_email => current_user.email)
      @locations = []
      @id = params[:id]

      puts "locs------------------ #{@locs}"
      @locations = Location.where(:owner_email=>current_user.email, :id => @id)
      puts "locs_after------------------ #{@locations}"
      if @locations.empty?
        @locations=@locs
      end
      @json = @locations.first.to_gmaps4rails do |location, marker|
        marker.infowindow render_to_string(:partial => "desc_add", :locals => {:object => location})
        puts "locations #{location.id}"
        @center_latitude = @locs.first.latitude
        puts "latitite  #{@center_latitude}"
        @center_longitude = @locs.first.longitude        
        puts "longitude #{@center_longitude}"
      end

  end

  def houses
    puts "____-----------------------------index_____________"
  @locals = Location.all
    @locs = []

    @locals.each do |l| 
      if l.owner_email.index(current_user.email)
        @locs << l
      end
    end
    
    @search = params[:search]
    @locations = []
    @locs.each do |l|
      if l.address.index(@search.to_s) && @search !="" && @search !=nil
        @locations<<l
      end
    end
    if @locations.empty?
      @locations = @locs
    end
    @search = params[:search]
    #@zoom=4
    @json = @locations.to_gmaps4rails do |location, marker|
      marker.infowindow render_to_string(:partial => "desc_add", :locals => {:object => location})
    end
    puts "Controller req: " + request.url.split("/").last
    #respond_with @json

    if @search
      respond_to do |format|
        format.js {}
        format.html {}
      end
    end

  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(params[:location])
    @location.owner_email = current_user.email

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end
  def excel
    Spreadsheet.client_encoding = 'UTF-8'
    if params[:dump].blank?
      flash[:error] = "No file selected"
      redirect_to("/locations")
      return
    end
    uploaded_io = params[:dump][:excel_file]
    File.open(Rails.root.join('app', 'assets', 'files', uploaded_io.original_filename), 'wb+') do |file|
      file.write(uploaded_io.read)
    end

      addresses = []
      zips = []
      a_n = nil
      z_n = nil
      row_size = 0
      col_size = 0
      
      parcelNumber_Value = []
      altParcelNumber_Value = [] 
      name_Value=[]
      name2_Value=[]
      grossLandValue_Value=[]
      grossImprovementValue_Value=[]
      grossAssessedValue_Value=[]
      neighborhoodName_Value=[]
      propertyClass_Value=[]
      propertySubClass_Value=[]
      taxYear_Value=[]
      yrConstructed_Value=[]
      fullBaths_Value=[]
      halfBaths_Value=[]
      bedrooms_Value=[]
      improvementType_Value=[]
      
      pn_v=nil
      apn_v=nil
      n_v=nil
      n2_v=nil
      glv_v=nil
      giv_v=nil
      gav_v=nil
      nhn_v=nil
      pc_v=nil
      psc_v=nil
      ty_v=nil
      yc_v=nil
      fb_v=nil
      hb_v=nil
      br_v=nil
      it_v=nil

   
    if uploaded_io.original_filename.split(".").last == "xls"

      book = Spreadsheet.open("#{Rails.root}/app/assets/files/#{uploaded_io.original_filename}")
      sheet1 = book.worksheet 0
      sheet1.each do |row|
        row_size = row.size
        if row[0]!=''
          col_size +=1
        end
      end
      col_size+=1
      row_size.times do |i|
        sheet1.each do |row|
          if row!='' || row!=nil
            if a_n==i
              addresses<<row[i].to_s
            elsif z_n==i
              zips<<row[i].to_i 
            end
            if row[i].to_s == 'Address' || row[i].to_s == 'address' || row[i].to_s == 'FullAddress1_Value'
              a_n=i
            elsif row[i].to_s == 'Zip+4' || row[i].to_s == 'zip code' || row[i].to_s=='Zip_Value'
              z_n=i
            end
          end
        end
      end
#      load("#{Rails.root}/app/assets/files/Property/address.rb")
    else

      oo = Excelx.new("#{Rails.root}/app/assets/files/#{uploaded_io.original_filename}")
      oo.default_sheet = oo.sheets.first
      oo.default_sheet = oo.sheets.first
      row_size = oo.last_row
      puts "row_size #{row_size}"
      col_size = oo.last_column
      puts "col_size #{col_size}"
      1.upto(col_size) do |i|
        if oo.cell(1,i)=="Address" || oo.cell(1,i)=="address" || oo.cell(1,i) == 'FullAddress1_Value'
          a_n=i
        elsif oo.cell(1,i)=="Zip+4" || oo.cell(1,i)=="zip code" || oo.cell(1,i)=='Zip_Value'
          z_n=i
        elsif oo.cell(1,i)=="ParcelNumber_Value"
          pn_v=i
        elsif oo.cell(1,i)=="AltParcelNumber_Value"
          apn_v=i
        elsif oo.cell(1,i)=="Name_Value"
          n_v=i
        elsif oo.cell(1,i)=="Name2_Value"
          n2_v=i
        elsif oo.cell(1,i)=="GrossLandValue_Value"
          glv_v=i
        elsif oo.cell(1,i)=="GrossImprovementValue_Value"
          giv_v=i
        elsif oo.cell(1,i)=="GrossAssessedValue_Value"
          gav_v=i
        elsif oo.cell(1,i)=="NeighborhoodName_Value"
          nhn_v=i
        elsif oo.cell(1,i)=="PropertyClass_Value"
          pc_v=i
        elsif oo.cell(1,i)=="PropertySubClass_Value"
          psc_v=i
        elsif oo.cell(1,i)=="TaxYear_Value"
          ty_v=i
        elsif oo.cell(1,i)=="YrConstructed_Value"
          yc_v=i
        elsif oo.cell(1,i)=="FullBaths_Value"
          fb_v=i
        elsif oo.cell(1,i)=="HalfBaths_Value"
          hb_v=i
        elsif oo.cell(1,i)=="Bedrooms_Value"
          br_v=i
        elsif oo.cell(1,i)=="ImprovementType_Value"
          it_v=i
        end 
        1.upto(row_size) do |j|
          if (oo.cell(j,i)!='' || oo.cell(j,i)!=nil) && j!=1
            if a_n==i
              addresses<<oo.cell(j,i).to_s
            elsif z_n==i
              zips<<oo.cell(j,i) 
            elsif pn_v==i
              parcelNumber_Value<<oo.cell(j,i) 
            elsif apn_v==i
              altParcelNumber_Value<<oo.cell(j,i) 
            elsif n_v==i
              name_Value<<oo.cell(j,i) 
            elsif n2_v==i
              name2_Value<<oo.cell(j,i) 
            elsif glv_v==i
              grossLandValue_Value<<oo.cell(j,i) 
            elsif giv_v==i
              grossImprovementValue_Value<<oo.cell(j,i) 
            elsif gav_v==i
              grossAssessedValue_Value<<oo.cell(j,i) 
            elsif nhn_v==i
              neighborhoodName_Value<<oo.cell(j,i) 
            elsif pc_v==i
              propertyClass_Value<<oo.cell(j,i) 
            elsif psc_v==i
              propertySubClass_Value<<oo.cell(j,i) 
            elsif ty_v==i
              taxYear_Value<<oo.cell(j,i) 
            elsif yc_v==i
              yrConstructed_Value<<oo.cell(j,i) 
            elsif fb_v==i
              fullBaths_Value<<oo.cell(j,i) 
            elsif hb_v==i
              halfBaths_Value<<oo.cell(j,i) 
            elsif br_v==i
              bedrooms_Value<<oo.cell(j,i) 
            elsif it_v==i
              improvementType_Value<<oo.cell(j,i) 
            end
          end
        end
      end
    end        

    addresses.size.times do |i|

      @location = Location.new(:address => addresses[i], :zip => zips[i], :owner_email => current_user.email, :parcelNumber_Value => parcelNumber_Value[i],  :altParcelNumber_Value => altParcelNumber_Value[i], :name_Value => name_Value[i], :name2_Value => name2_Value[i], :grossLandValue_Value => grossLandValue_Value[i], :grossImprovementValue_Value => grossImprovementValue_Value[i], :grossAssessedValue_Value => grossAssessedValue_Value[i], :neighborhoodName_Value => neighborhoodName_Value[i], :propertyClass_Value => propertyClass_Value[i], :propertySubClass_Value => propertySubClass_Value[i], :taxYear_Value => taxYear_Value[i], :yrConstructed_Value => yrConstructed_Value[i], :fullBaths_Value => fullBaths_Value[i], :halfBaths_Value => halfBaths_Value[i], :bedrooms_Value => bedrooms_Value[i], :improvementType_Value => improvementType_Value[i])
      @location.save
    end

#    @locations = Location.all
    redirect_to("/locations") 

  end  

  def authenticate
    puts "____-----------------------------authenti_____________----------"
    redirect_to("/users/sign_in") unless user_signed_in?
  end

  def desc_add
    @location = Location.find(params[:id])
    @desc_add = params[:description].to_s
    @location.description = @desc_add
    @location.save

    if @location.update_attributes(params[:location])
      respond_to do |format|
        format.html {redirect_to("/houses")}
        format.js
      end      
    end
  end

  def map 
  end
end
