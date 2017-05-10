require 'minitest/autorun'

require_relative 'citrus_byte.rb'
describe ArrayTool do
  it "can flatten an array of integers" do
    input = [[1,2,[3]],4]
    result = [1,2,3,4]
    ArrayTool.flatten(input).must_equal(result)
  end

  it "can handle an empty array" do
    ArrayTool.flatten([]).must_equal([])
  end

  it "raises an error on anything other than an integer" do
    input = ["some string"]
    proc {ArrayTool.flatten(input)}.must_raise(ArgumentError)
  end

end
