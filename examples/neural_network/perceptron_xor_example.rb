require File.dirname(__FILE__) + '/../../lib/ai4r/neural_network/perceptron'
require 'benchmark'

times = Benchmark.measure do

  weights = [[[-1.0, -1.0], [-1.0, -1.0], [1.5, 0.5]], [[1.0], [-1.0], [-0.5]]]
  net = Ai4r::NeuralNetwork::Perceptron.new([2, 2, 1], weights)
    
  puts "Test data"
  puts "[0,0] = > #{net.eval([0,0]).inspect}"
  puts "[0,1] = > #{net.eval([0,1]).inspect}"
  puts "[1,0] = > #{net.eval([1,0]).inspect}"
  puts "[1,1] = > #{net.eval([1,1]).inspect}"
end

puts "Elapsed time: #{times}"