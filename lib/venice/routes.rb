module Venice
  class Lotsman
    class Routes < Struct.new(:lotsman, :start, :finish)
      def shortest_distance
        d = Venice::Dijkstra.new(lotsman.canals)
        d.solve(start, finish)
      end

      def max_distance(max_cost)
        nw = Venice::Naive.new(lotsman.canals)
        nw.solve(start, finish, max_cost: max_cost)
      end
     
      def max_stops(max_stops)
        nw = Venice::Naive.new(lotsman.canals)
        nw.solve(start, finish, max_stops: max_stops)
      end

      def stops(stops)
        nw = Venice::Naive.new(lotsman.canals)
        nw.solve(start, finish, stops: stops)
      end
    end
  end
end