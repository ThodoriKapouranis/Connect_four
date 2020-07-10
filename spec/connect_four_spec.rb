require "./lib/connect_four.rb"

describe Game do
  describe "#place" do 
    it "returns array with pos and symbol" do
      game = Game.new
      expect(game.place(0)).to eql([[0,0],"⚪"])
    end

    it "alternates between colors" do
      game= Game.new
      game.place(0)
      expect(game.place(1)).to eql([[0,1],"⚫"])
    end

    it "can stack and return correct pos" do
      game = Game.new
      game.place(0)
      game.place(0)
      expect(game.place(0)).to eql([[2,0],"⚪"])
    end
  
    it "returns false on out of bounds vertical placement" do
      game= Game.new
      game.place(0)
      game.place(0)
      game.place(0)
      game.place(0)
      game.place(0)
      game.place(0)
      expect(game.place(0)).to eql(false)
    end
    it "returns false on out of bounds horizontal placement" do
      game= Game.new
      expect(game.place(-1)).to eql(false)
    end

    it "returns true on left-right horizontal victory" do
      game=Game.new
      game.place(0) #R
      game.place(0)
      game.place(1) #R
      game.place(0)
      game.place(2) #R
      game.place(0)
      expect(game.place(3)).to eql(true)
    end

    it "returns true on right-left horizontal victory" do
      game=Game.new
      game.place(6) #R
      game.place(0)
      game.place(5) #R
      game.place(0)
      game.place(4) #R
      game.place(0)
      expect(game.place(3)).to eql(true)
    end
    it "returns true on vertical victory" do
      game=Game.new
      game.place(0) #R
      game.place(1)
      game.place(0) #R
      game.place(2)
      game.place(0) #R
      game.place(3)
      expect(game.place(0)).to eql(true)
    end

    it "returns true on diagonal victory" do
      game=Game.new
      game.place(0)
      game.place(1)
      game.place(1)
      game.place(2)
      game.place(3)
      game.place(2)
      game.place(2)
      game.place(3)
      game.place(4)
      game.place(3)
      expect(game.place(3)).to eql(true)
    end
  end
end
