RSpec.describe ShortFind do
  it "has a version number" do
    expect(ShortFind::VERSION).not_to be nil
  end

  class Thing
    attr_reader :name, :color

    @@all = []

    def self.all
      @@all
    end

    def initialize(name, color)
      @name = name
      @color = color
      @@all << self
    end
  end

  ONE = Thing.new("One", "blue")
  TWO = Thing.new("Two", "black")
  THREE = Thing.new("Three", "red")
  FOUR = Thing.new("f-Our & two", "yellow")
  FIVE = Thing.new("3423", "white")

  THINGS = Thing.all
  ARRAY = ["one", "two", "three", "3423", "f-Our & two"]
  HASH = {"one" => "onev", :two => "twov", :three => "threev", "3423" => "3423v", "f-Our & two" => "f-Our & two v"}

  describe ".in_array" do
    context "when one match is found" do
      it "returns the matching element" do
        allow(ShortFind).to receive(:gets).and_return("on")
        expect(ShortFind.in_array(ARRAY)).to eq "one"
      end
    end

    context "when no match is found" do
      it "puts no match found error" do
        ShortFind.use_back(true)
        allow(ShortFind).to receive(:gets).and_return("www", "back")
        expect($stdout).to receive(:puts).with("")
        expect($stdout).to receive(:puts).with("No match found")
        expect($stdout).to receive(:puts).with("Try again")
        ShortFind.in_array(ARRAY)
      end
    end

    context "when multiple matches are found" do
      it "puts multiple match found error" do
        ShortFind.use_back(true)
        allow(ShortFind).to receive(:gets).and_return("t", "back")
        expect($stdout).to receive(:puts).with("").exactly(3).times
        expect($stdout).to receive(:puts).with("Multiple matches found")
        expect($stdout).to receive(:puts).with("two")
        expect($stdout).to receive(:puts).with("three")
        expect($stdout).to receive(:puts).with("Try again")
        ShortFind.in_array(ARRAY)
      end
    end

    it "ignores case, spaces and special characters in the element" do
      allow(ShortFind).to receive(:gets).and_return("fourt")
      expect(ShortFind.in_array(ARRAY)).to eq "f-Our & two"
    end

    it "ignores case, spaces and special characters in the input" do
      allow(ShortFind).to receive(:gets).and_return("Th r-e")
      expect(ShortFind.in_array(ARRAY)).to eq "three"
    end

    it "accepts numbers" do
      allow(ShortFind).to receive(:gets).and_return("34")
      expect(ShortFind.in_array(ARRAY)).to eq "3423"
    end
  end

  describe ".in_hash" do
    context "when searching by value" do
      context "when one match is found" do
        it "returns an element" do
          allow(ShortFind).to receive(:gets).and_return("on")
          expect(ShortFind.in_hash(HASH)).to eq "one" => "onev"
        end
      end

      context "when no match is found" do
        it "puts no match found error" do
          ShortFind.use_back(true)
          allow(ShortFind).to receive(:gets).and_return("www", "back")
          expect($stdout).to receive(:puts).with("")
          expect($stdout).to receive(:puts).with("No match found")
          expect($stdout).to receive(:puts).with("Try again")
          ShortFind.in_hash(HASH)
        end
      end

      context "when multiple matches are found" do
        it "puts multiple match found error" do
          ShortFind.use_back(true)
          allow(ShortFind).to receive(:gets).and_return("t", "back")
          expect($stdout).to receive(:puts).with("").exactly(3).times
          expect($stdout).to receive(:puts).with("Multiple matches found")
          expect($stdout).to receive(:puts).with("twov")
          expect($stdout).to receive(:puts).with("threev")
          expect($stdout).to receive(:puts).with("Try again")
          ShortFind.in_hash(HASH)
        end
      end

      it "ignores case, spaces and special characters in the value" do
        allow(ShortFind).to receive(:gets).and_return("fourt")
        expect(ShortFind.in_hash(HASH)).to eq "f-Our & two" => "f-Our & two v"
      end

      it "ignores case, spaces and special characters in the input" do
        allow(ShortFind).to receive(:gets).and_return("Th r-e")
        expect(ShortFind.in_hash(HASH)).to eq :three => "threev"
      end

      it "accepts numbers" do
        allow(ShortFind).to receive(:gets).and_return("34")
        expect(ShortFind.in_hash(HASH)).to eq "3423" => "3423v"
      end

    end
  end

  context "when searching by key" do
    context "when one match is found" do
      context "when the key is a string" do
        it "returns an element" do
          allow(ShortFind).to receive(:gets).and_return("on")
          expect(ShortFind.in_hash(HASH, :key)).to eq "one" => "onev"
        end
      end

      context "when the key is a symbol" do
        it "returns an element" do
          allow(ShortFind).to receive(:gets).and_return("tw")
          expect(ShortFind.in_hash(HASH, :key)).to eq :two => "twov"
        end
      end
    end

    context "when no match is found" do
      it "puts no match found error" do
        ShortFind.use_back(true)
        allow(ShortFind).to receive(:gets).and_return("www", "back")
        expect($stdout).to receive(:puts).with("")
        expect($stdout).to receive(:puts).with("No match found")
        expect($stdout).to receive(:puts).with("Try again")
        ShortFind.in_hash(HASH, :key)
      end
    end

    context "when multiple matches are found" do
      it "puts multiple match found error" do
        ShortFind.use_back(true)
        allow(ShortFind).to receive(:gets).and_return("t", "back")
        expect($stdout).to receive(:puts).with("").exactly(3).times
        expect($stdout).to receive(:puts).with("Multiple matches found")
        expect($stdout).to receive(:puts).with(:two)
        expect($stdout).to receive(:puts).with(:three)
        expect($stdout).to receive(:puts).with("Try again")
        ShortFind.in_hash(HASH, :key)
      end
    end

    it "ignores case, spaces and special characters in the key" do
      allow(ShortFind).to receive(:gets).and_return("fourt")
      expect(ShortFind.in_hash(HASH, :key)).to eq "f-Our & two" => "f-Our & two v"
    end

    it "ignores case, spaces and special characters in the input" do
      allow(ShortFind).to receive(:gets).and_return("Th r-e")
      expect(ShortFind.in_hash(HASH, :key)).to eq :three => "threev"
    end

    it "accepts numbers" do
      allow(ShortFind).to receive(:gets).and_return("34")
      expect(ShortFind.in_hash(HASH, :key)).to eq "3423" => "3423v"
    end
  end

  describe ".object" do
    context "when one match is found" do
      it "returns an object" do
        allow(ShortFind).to receive(:gets).and_return("on")
        expect(ShortFind.object(THINGS)).to eq ONE
      end
    end

    context "when no match is found" do
      it "puts no match found error" do
        ShortFind.use_back(true)
        allow(ShortFind).to receive(:gets).and_return("www", "back")
        expect($stdout).to receive(:puts).with("")
        expect($stdout).to receive(:puts).with("No match found")
        expect($stdout).to receive(:puts).with("Try again")
        ShortFind.object(THINGS)
      end
    end

    context "when multiple matches are found" do
      it "puts multiple match found error" do
        ShortFind.use_back(true)
        allow(ShortFind).to receive(:gets).and_return("t", "back")
        expect($stdout).to receive(:puts).with("").exactly(3).times
        expect($stdout).to receive(:puts).with("Multiple matches found")
        expect($stdout).to receive(:puts).with("Two")
        expect($stdout).to receive(:puts).with("Three")
        expect($stdout).to receive(:puts).with("Try again")
        ShortFind.object(THINGS)
      end
    end

    it "ignores case, spaces and special characters in the attribute" do
      allow(ShortFind).to receive(:gets).and_return("fourt")
      expect(ShortFind.object(THINGS)).to eq FOUR
    end

    it "ignores case, spaces and special characters in the input" do
      allow(ShortFind).to receive(:gets).and_return("Th r-e")
      expect(ShortFind.object(THINGS)).to eq THREE
    end

    it "accepts numbers" do
      allow(ShortFind).to receive(:gets).and_return("34")
      expect(ShortFind.object(THINGS)).to eq FIVE
    end

    it "works with an attribute other than name" do
      allow(ShortFind).to receive(:gets).and_return("blu")
      expect(ShortFind.object(THINGS, :color)).to eq ONE
    end
  end
end
