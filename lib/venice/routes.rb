module Venice
  class Lotsman
    Routes = Struct.new(:lotsman, :start, :finish)

    class Routes
      def shortest_distance
        @min_path=("A".."E").to_a.product([Float::INFINITY]).to_h
        @routes = []
        @visited = []
        @max_total_cost = Float::INFINITY
        @canals = lotsman.canals.dup
        dijkstra(start, finish)
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

      def dijkstra(source, destination, cost=0)
        @visited += [source]
        @canals[source].each do |d,c|
          if @min_path[d] > cost+c
            @routes += [source+d, @min_path[d] = cost+c]
          end
        end
        
        @canals.each{|h| h.delete(source)}
       
        new_source,  = @min_path.each.reject{|k| @visited.include? k.first}.min_by &:last
       
        return @min_path[destination] if new_source == destination || new_source.nil?
       
        dijkstra(new_source, destination, @min_path[new_source])     
      end
    end
  end
end