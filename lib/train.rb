class Train
  attr_accessor :name, :id

  # create a train
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id, nil)
  end

  # ensure two trains are the same if they have the same name
  def ==(train_to_compare)
    self.name() == train_to_compare.name()
  end
  #
  # save a train
  def save
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  # read all trains
  def self.all
    returned_trains = DB.exec('SELECT * FROM trains;')
    trains = []
    returned_trains.each() do |train|
      name = train.fetch('name')
      id = train.fetch('id').to_i
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end

  # update a train
  def update(name)
    @name = name
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{@id};")
  end

  #delete a train
  def delete
    DB.exec("DELETE FROM trains WHERE id = #{@id};")
  end

  #clear train database
  def self.clear
    DB.exec("DELETE FROM trains *;")
  end

  # find a train by id
  def self.find(id)
    train = DB.exec("SELECT * FROM trains WHERE id = #{id};").first
    name = train.fetch("name")
    id = train.fetch("id").to_i
    Train.new({:name => name, :id => id})
  end

  def get_stops
    returned_stops = DB.exec("SELECT * FROM stops WHERE train_id = #{@id}")
    stops = []
    returned_stops.each do |stop|
      train_id = stop.fetch('train_id')
      city_id = stop.fetch('city_id')
      time = stop.fetch('time')
      stops.push({:train_id => train_id, :city_id => city_id, :time => time})
    end
    stops
  end

end
