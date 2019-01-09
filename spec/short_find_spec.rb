RSpec.describe ShortFind do
  it "has a version number" do
    expect(ShortFind::VERSION).not_to be nil
  end

  @array = ["one", "two", "three"]
  @hash = {"one" => "onev", :two => "twov", :three => "threev"}

  describe ".in_array" do
    expect("1").to eq "1"
  end


end
