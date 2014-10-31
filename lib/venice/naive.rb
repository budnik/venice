module Venice
  class Naive < Struct.new(:canals)
    def solve(start, finish, stops: nil, max_stops: stops, max_cost: Float::INFINITY)
      max_stops ||= stops || Float::INFINITY

      go = ->(dest, cost=0, route=dest) do
        return [] if route.size > max_stops

        routes_available = canals[dest].to_a.reject{|_, trip_cost| cost+trip_cost > max_cost}

        routes_available.flat_map do |next_trip, trip_cost|
          if next_trip == finish and not (stops and stops != route.size)
            [route + next_trip]
          end.to_a + go[next_trip, cost+trip_cost, route+next_trip]
        end.compact
      end

      go[start]
    end
  end
end
