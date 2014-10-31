module Venice
  class Lotsman
    attr_reader :canals

    def initialize(canals="")
      @canals = case canals
        when Hash then canals
        when String then parse_canals(canals)
        else raise ArgumentError.new "route must be string or hash"
      end
    end

    def distance(*route)
      route.each_cons(2).map{|a,b| @canals[a][b]}.reduce(:+)
    rescue
      "NO SUCH ROUTE"
    end

    def routes(from_to)
      from, to = from_to.first

      Routes.new(self, from, to)
    end

    private

    def parse_canals(string)
      canals = string.scan(/\b[A-E]{2}\d+\b/)
      canals.map!(&:chars)
      canals.map!{|src, dest, *dist| [src, dest, dist.join.to_i]}
      canals.group_by(&:shift).map{|src, destinations| [src, destinations.to_h]}.to_h
    end
  end
end