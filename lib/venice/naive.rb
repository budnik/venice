module Venice
  class Naive < Struct.new(:canals)
    def solve(start, finish, stops: nil, max_stops: (stops||Float::INFINITY), max_cost: Float::INFINITY)
      go = ->(destination, cost=0, route=destination) do
        return [] if canals[destination].nil? || route.size > max_stops

        canals[destination].reject{|_, c| cost+c > max_cost}.flat_map do |next_trip, trip_cost|
          routes = []
          if next_trip != finish
          elsif stops and stops != route.size
          elsif cost > max_cost and max_cost < Float::INFINITY
          else
            routes << route + next_trip
          end
          routes += go[next_trip, cost+trip_cost, route+next_trip].compact
        end
      end

      go[start]
    end
  end
end
