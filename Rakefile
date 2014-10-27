require 'rake/testtask'

task :default => :test
Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task :solve do
  $:.unshift 'lib'
  require 'venice'
  l = Venice::Lotsman.new("AB5 BC4 CD8 DC8 DE6 AD5 CE2 EB3 AE7")
  
  puts l.distance('A', 'B', 'C')
  puts l.distance('A', 'D')
  puts l.distance('A', 'D', 'C')
  puts l.distance('A', 'E', 'B', 'C', 'D')
  puts l.distance('A', 'E', 'D')
  puts l.routes('C' => 'C').max_stops(3).count
  puts l.routes('A' => 'C').stops(4).count
  puts l.routes('A' => 'C').shortest_distance
  puts l.routes('B' => 'B').shortest_distance
  puts l.routes('C' => 'C').max_distance(29).count
end