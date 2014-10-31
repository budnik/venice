require 'minitest/autorun'
require 'minitest/pride'
require 'venice'

class Venice::TestLotsmanCanalsParser < MiniTest::Unit::TestCase
  def setup
    @parse = Venice::Lotsman.new.method :parse_canals
  end

  def test_parse_canals_invalid
    assert_equal(Hash.new, @parse["AAB1"])
    assert_equal(Hash.new, @parse["AAB"])
    assert_equal(Hash.new, @parse["AB"])
    assert_equal(Hash.new, @parse["AB1AB1"])
    assert_equal(Hash.new, @parse["ab"])
    assert_equal(Hash.new, @parse["1AB1AB"])
    assert_equal(Hash.new, @parse["AB1foo"])
  end

  def test_parse_canals
    assert_equal(Hash.new, @parse[""], "should parse empty string")
    assert_equal({"A"=>{"B"=>100}}, @parse["AB100"])
    assert_equal({"A"=>{"B"=>1}}, @parse["AB1"])
    assert_equal({"A"=>{"B"=>1}}, @parse["AB1\n"])
    assert_equal({"A"=>{"B"=>1}}, @parse["\nAB1\n"])

    assert_equal(@parse["AB1 AC2"],  {"A"=>{"B"=>1, "C"=>2}})
    assert_equal(@parse["AB1 CA1"],  {"A"=>{"B"=>1}, "C"=>{"A"=>1}})

    assert_equal(@parse["AB1, AC2"],  {"A"=>{"B"=>1, "C"=>2}})
    assert_equal(@parse["AB1, CA1"],  {"A"=>{"B"=>1}, "C"=>{"A"=>1}})

    assert_equal(@parse["\nAB1\nAC2"],  {"A"=>{"B"=>1, "C"=>2}})
    assert_equal(@parse["\nAB1\nCA1"],  {"A"=>{"B"=>1}, "C"=>{"A"=>1}})
  end

  def test_parse_canals_arguments
    assert_raises(ArgumentError, "should not parse w/o argument") do
      @parse[]
    end

    assert_raises(ArgumentError, "should not parse w/ 2 argument") do
      @parse[1,2]
    end  
  end
end
