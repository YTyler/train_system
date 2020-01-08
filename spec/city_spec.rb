require('city')
require('rspec')
require('pry')

describe('.#City') do

  describe('#==') do
    it("is the same city if it has the same attributes as another city") do
      city1 = City.new({:name => 'Chicago', :id => nil})
      city2 = City.new({:name => 'Chicago', :id => nil})
      expect(city1).to(eq(city2))
    end
  end


end
