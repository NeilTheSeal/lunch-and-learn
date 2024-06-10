class TouristSite
  attr_reader :id, :name, :address, :place_id

  def initialize(feature)
    @id = nil
    @name = feature[:properties][:name]
    @address = feature[:properties][:formatted]
    @place_id = feature[:properties][:place_id]
  end
end
