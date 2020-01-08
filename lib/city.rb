class City
  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name) || nil
    @id = attributes.fetch(:id, nil)
  end

  def ==(city_to_compare)
    self.name() == city_to_compare.name()
  end

end
