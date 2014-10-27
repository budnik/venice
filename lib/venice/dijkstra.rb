module Venice
  class Dijkstra
    def initialize(canals)
      @canals = canals.dup
      @min_path=("A".."E").to_a.product([Float::INFINITY]).to_h
      @visited = []
    end

    def solve(source, destination, cost=0)
      @visited += [source]
      @canals[source].each do |d,c|
        if @min_path[d] > cost+c
          @min_path[d] = cost+c
        end
      end
      
      @canals.each{|h| h.delete(source)}
     
      new_source, = @min_path.reject{|k| @visited.include? k.first}.min_by &:last
     
      if new_source == destination || new_source.nil?
        @min_path[destination]
      else
        solve(new_source, destination, @min_path[new_source])     
      end
    end
  end
end
