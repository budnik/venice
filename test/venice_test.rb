require 'minitest/autorun'
require 'minitest/pride'
require 'venice'

describe Venice::Lotsman do
  describe '#new w/o arguments' do
    before { @lotsman = Venice::Lotsman.new }

    it 'should create Lotsman' do
      @lotsman.must_be_kind_of Venice::Lotsman
    end

    it 'canals should be empty' do
      @lotsman.canals.must_be_empty
    end

    it '#distance should respond w/ string for missing route' do
      @lotsman.distance("A", "B", "C").must_be_kind_of String
      @lotsman.distance("A", "B", "C").match 'NO SUCH ROUTE'
    end

    it '#distance should respond w/ ??? w/o args' do
      skip 'undefined'
    end

    describe '#routes' do
      before { @routes = @lotsman.routes('A'=>'Z') }

      it 'should respond with Routes' do
        @routes.must_be_kind_of Venice::Lotsman::Routes
      end
    end
  end
end
