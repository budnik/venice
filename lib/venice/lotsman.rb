require 'venice/routes'

module Venice
  class Lotsman
    attr_reader :canals

    def initialize(canals="")
      @canals = canals.scan(/[A-E]{2}\d+/).map(&:chars).map{|s,d,*v|[s,d,v.join.to_i]}.group_by(&:shift).map{|k,v| [k, v.to_h]}.to_h
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
  end
end