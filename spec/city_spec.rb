require('spec_helper')

describe('.#City') do

  describe('#==') do
    it("is the same city if it has the same attributes as another city") do
      city1 = City.new({:name => 'Chicago', :id => nil})
      city2 = City.new({:name => 'Chicago', :id => nil})
      expect(city1).to(eq(city2))
    end
  end

  describe(".all") do
    it("returns an empty array when there are no cities") do
      expect(City.all()).to(eq([]))
    end
  end


  describe('#save') do
    it("saves an city") do
      city = City.new({:name => "Chicago", :id => nil}) # nil added as second argument
      city.save()
      city2 = City.new({:name => "Portland", :id => nil}) # nil added as second argument
      city2.save()
      expect(City.all).to(eq([city, city2]))
    end
  end

  describe('.clear') do
    it("clears all cities") do
      city = City.new({:name => "Chicago", :id => nil})
      city.save()
      city2 = City.new({:name => "Portland", :id => nil})
      city2.save()
      City.clear()
      expect(City.all).to(eq([]))
    end
  end

  describe('#update') do
    it("updates an city by id") do
      city = City.new({:name => "Chicago", :id => nil})
      city.save()
      city.update("Portland")
      expect(city.name).to(eq("Portland"))
    end
  end

  describe('#delete') do
    it("deletes an city") do
      city = City.new({:name => "Chicago", :id => nil})
      city.save()
      city2 = City.new({:name => "Portland", :id => nil})
      city2.save()
      city.delete()
      expect(City.all).to(eq([city2]))
    end
  end

  describe('.find') do
    it("finds a city by id") do
      city = City.new({:name => "Chicago", :id => nil})
      city.save()
      city2 = City.new({:name => "Portland", :id => nil})
      city2.save()
      expect(City.find(city.id)).to(eq(city))
    end
  end

end
