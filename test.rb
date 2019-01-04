require 'pry'
require_relative "lib/short_find.rb"

ShortFind.use_exit(true)

array = ["one", "two", "three", "four"]
hash = {"onekey" => "onevalue", :twokey => "twovalue", "threekey" => "threevalue"}

class Thing
  attr_reader :name, :style
  @@all = []
  def self.all
    @@all
  end
  def initialize(name, style)
    @name = name
    @style = style
    @@all << self
  end
end

Thing.new("One", "Cool")
Thing.new("Two", "Cold")
Thing.new("Three", "Wild")

objects = Thing.all


binding.pry
