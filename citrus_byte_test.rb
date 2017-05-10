require 'minitest/autorun'

require_relative 'citrus_byte.rb'

describe ArrayTool do

  it "can flatten an array of integers" do
    input  = [[1,2,[3]],4]
    result = [1,2,3,4]
    ArrayTool.flatten(input).must_equal(result)
  end

  it "makes sure an empty array returns an empty array" do
    ArrayTool.flatten([]).must_equal([])
  end

  it "can flatten a deeply nested array" do
    input  = [[[[[12345]]]]]
    result = [12345]
    ArrayTool.flatten(input).must_equal(result)
  end

  it "raises an error on anything other than an integer" do
    input = ["some string"]
    proc { ArrayTool.flatten(input) }.must_raise(ArgumentError)
  end

  it "can demonstrate Ruby's recursion weaknesses" do
    input = (1..10_000).reduce([1]) { |acc,_| [acc] }
    ArrayTool.flatten(input).must_equal([1])
  end

end
