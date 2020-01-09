require('sinatra')
require('sinatra/reloader')
require('pry')
require('pg')
require('./lib/train')
require('./lib/city')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'train_system'})

get('/') do
  redirect to('/home')
end

get('/home') do
  erb(:home)
end

#Employee Requests

get('/home/employee') do
  @trains = Train.all
  @cities = City.all
  erb(:employee)
end

#Employee Train Requests
get('/home/employee/trains/new') do
  erb(:new_train)
end

get('/home/employee/trains/:id') do
  @train = Train.find(params[:id].to_i)
  @stops = @train.get_stops
  erb(:train)
end

get('/home/employee/trains/:id/edit') do
  @train = Train.find(params[:id].to_i)
  @stops = @train.get_stops
  erb(:train_edit)
end

patch('/home/employee/trains/:id') do
  @train = Train.find(params[:id].to_i)
  @train.update(params[:name])
  @stops = @train.get_stops
  erb(:train)
end

post('/home/employee/trains') do
  train = Train.new(params)
  train.save
  # @trains = Train.all
  # @cities = City.all
  redirect to('/home/employee')
end

#Employee City Requests
get('/home/employee/cities/new') do
  erb(:new_city)
end

get('/home/employee/cities/:id') do
  @city = City.find(params[:id].to_i)
  @stops = @city.get_stops

  erb(:city)
end

post('/home/employee/cities') do
  city = City.new(params)
  city.save
  @trains = Train.all
  @cities = City.all
  erb(:employee)
end

get('/home/employee/cities/:id/edit') do
  @city = City.find(params[:id].to_i)
  @stops = @city.get_stops
  erb(:city_edit)
end

patch('/home/employee/cities/:id') do
  @city = City.find(params[:id].to_i)
  @city.update(params[:name])
  @stops = @city.get_stops
  erb(:city)
end

get('/home/employee/add') do
  @trains = Train.all
  @cities = City.all
  erb(:add_stop)
end

post('/home/employee/add') do
  train_id = params[:train]
  city_id = params[:city]
  time = params[:time]
  DB.exec("INSERT INTO stops (train_id, city_id, time) VALUES (#{train_id}, #{city_id}, #{time});")
  redirect to ('/home/employee')
end

#Rider Requests

get('/home/rider') do
  @trains = Train.all
  @cities = City.all
  erb(:rider)
end

get('/home/rider/cities/:id') do
  @city = City.find(params[:id].to_i)
  @stops = @city.get_stops

  erb(:rider_city)
end

get('/home/rider/trains/:id') do
  @train = Train.find(params[:id].to_i)
  @stops = @train.get_stops
  erb(:rider_train)
end

get('/home/timetable') do
  @trains = Train.all
  @cities = City.all
  erb(:timetable)
end

get('/home/ticket/:id') do
  @stop = DB.exec("SELECT * FROM stops WHERE id = #{params[:id]}").first
  erb(:ticket)
end

get('/destroy') do
  Train.clear
  City.clear
  DB.exec("DELETE FROM stops *")
  redirect to('/home/employee')
end
