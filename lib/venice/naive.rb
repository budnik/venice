module Venice
  class Naive < Struct.new(:canals)
    def solve(start, finish, max_cost: Float::INFINITY, stops: nil, max_stops: stops||Float::INFINITY)
      ok_length = (stops.to_i..max_stops)

      go = ->(dest, cost=0, route=dest) do
        if route.size < ok_length.last
          routes_available = canals[dest].to_a.reject{|_, trip_cost| cost + trip_cost > max_cost}

          routes_available.flat_map do |next_trip, trip_cost|
            if next_trip == finish and ok_length===route.size
              [route + next_trip]
            end.to_a + go[next_trip, cost+trip_cost, route+next_trip].to_a
          end.compact
        end
      end

      go[start]
    end
  end
end
