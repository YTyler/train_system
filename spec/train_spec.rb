require('spec_helper')

describe('.#Train') do

  describe('#==') do
    it("is the same train if it has the same attributes as another train") do
      train1 = Train.new({:name => 'Train one', :id => nil})
      train2 = Train.new({:name => 'Train one', :id => nil})
      expect(train1).to(eq(train2))
    end
  end

  describe(".all") do
    it("returns an empty array when there are no trains") do
      expect(Train.all()).to(eq([]))
    end
  end


  describe('#save') do
    it("saves an train") do
      train = Train.new({:name => "Train one", :id => nil}) # nil added as second argument
      train.save()
      train2 = Train.new({:name => "Train two", :id => nil}) # nil added as second argument
      train2.save()
      expect(Train.all).to(eq([train, train2]))
    end
  end

  describe('.clear') do
    it("clears all trains") do
      train = Train.new({:name => "Train one", :id => nil})
      train.save()
      train2 = Train.new({:name => "Train two", :id => nil})
      train2.save()
      Train.clear()
      expect(Train.all).to(eq([]))
    end
  end

  describe('#update') do
    it("updates an train by id") do
      train = Train.new({:name => "Train one", :id => nil})
      train.save()
      train.update("Train two")
      expect(train.name).to(eq("Train two"))
    end
  end

  describe('#delete') do
    it("deletes an train") do
      train = Train.new({:name => "Train one", :id => nil})
      train.save()
      train2 = Train.new({:name => "Train two", :id => nil})
      train2.save()
      train.delete()
      expect(Train.all).to(eq([train2]))
    end
  end

  describe('.find') do
    it("finds a train by id") do
      train = Train.new({:name => "Train one", :id => nil})
      train.save()
      train2 = Train.new({:name => "Train two", :id => nil})
      train2.save()
      expect(Train.find(train.id)).to(eq(train))
    end
  end

end
