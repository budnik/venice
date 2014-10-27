require 'venice/dijkstra'

module Venice
  class Lotsman
    Routes = Struct.new(:lotsman, :start, :finish)

    class Routes
      def shortest_distance
        d = Venice::Dijkstra.new(lotsman.canals)
        d.solve(start, finish)
      end

      def max_distance(max_cost)
        goto = ->(destination, cost=0, route=destination) do
          next if canals[destination].nil?
     
          canals[destination].reject{|_, c| cost+c > max_cost}.flat_map do |next_trip, trip_cost|
            routes = []
            if next_trip==finish and trip_cost < max_cost
              routes << route + next_trip
            end
            routes << goto.call(next_trip, cost+trip_cost, route+next_trip)
          end
        end
       
        goto[start].flatten.compact
      end
     
      def max_stops(max_stops)

        goto = ->(destination, cost=0, route=destination) do
          next if canals[destination].nil?
     
          canals[destination].flat_map do |next_trip, trip_cost|
            next if route.size > max_stops
            routes = []
            if next_trip==finish
              routes << route + next_trip
            end
            routes += goto.call(next_trip, cost+trip_cost, route+next_trip).compact
          end
        end
       
        goto[start]
      end
     
      def stops(stops)
        routes = []

        goto = ->(destination, cost=0, route=destination) do
          next if canals[destination].nil?
     
          canals[destination].each do |next_trip, trip_cost|
            if route.size == stops
              if next_trip==finish 
                routes << route + next_trip
              end
            else
              goto.call(next_trip, cost+trip_cost, route+next_trip)
            end
          end
        end
       
        goto[start]
        routes
      end

      private

      def canals
        lotsman.canals
      end
    end
  end
end