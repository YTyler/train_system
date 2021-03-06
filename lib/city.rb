class City
  attr_accessor :name, :id

  # create a city
  def initialize(attributes)
    @name = attributes.fetch(:name) || nil
    @id = attributes.fetch(:id, nil)
  end

  # ensure two cities are the same if they have the same name
  def ==(city_to_compare)
    self.name() == city_to_compare.name()
  end
  #
  # save a city
  def save
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  # read all cities
  def self.all
    returned_cities = DB.exec('SELECT * FROM cities;')
    cities = []
    returned_cities.each() do |city|
      name = city.fetch('name')
      id = city.fetch('id').to_i
      cities.push(City.new({:name => name, :id => id}))
    end
    cities
  end

  # update a city
  def update(name)
    @name = name
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
  end

  #delete a city
  def delete
    DB.exec("DELETE FROM cities WHERE id = #{@id};")
  end

  #clear city database
  def self.clear
    DB.exec("DELETE FROM cities *;")

  end

  # find a city by id
  def self.find(id)
    city = DB.exec("SELECT * FROM cities WHERE id = #{id};").first
    name = city.fetch("name")
    id = city.fetch("id").to_i
    City.new({:name => name, :id => id})
  end

  def get_stops
    returned_stops = DB.exec("SELECT * FROM stops WHERE city_id = #{@id}")
    stops = []
    returned_stops.each do |stop|
      id = stop.fetch('id')
      train_id = stop.fetch('train_id')
      city_id = stop.fetch('city_id')
      time = stop.fetch('time')
      stops.push({:train_id => train_id, :city_id => city_id, :time => time, :id => id})
    end
    stops
  end

end
