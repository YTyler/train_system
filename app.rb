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

get('/home/employee') do
  @trains = Train.all
  @cities = City.all
  erb(:employee)
end

get('/home/employee/trains/new') do
  erb(:new_train)
end

post('/home/employee/trains') do
  train = Train.new(params)
  train.save
  @trains = Train.all
  @cities = City.all
  erb(:employee)
end

get('/home/employee/trains/:id') do
  train = Train.find(params[:id].to_i)
  train.save
  erb(:train)
end

get('/home/employee/trains/new') do

end
