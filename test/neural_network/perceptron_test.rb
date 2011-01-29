require 'ai4r/neural_network/perceptron'
require 'test/unit'

Ai4r::NeuralNetwork::Perceptron.send(:public, *Ai4r::NeuralNetwork::Perceptron.protected_instance_methods)  
Ai4r::NeuralNetwork::Perceptron.send(:public, *Ai4r::NeuralNetwork::Perceptron.private_instance_methods)

module Ai4r
  module NeuralNetwork
    class PerceptronTest < Test::Unit::TestCase
      def test_init_network
        net = Perceptron.new([2, 2, 1], [[[-1.0, -1.0], [-1.0, -1.0], [1.5, 0.5]], [[1.0], [-1.0], [-0.5]]])
        assert_equal [2, 2, 1], net.structure
        assert_equal [[[-1.0, -1.0], [-1.0, -1.0], [1.5, 0.5]], [[1.0], [-1.0], [-0.5]]], net.weights
        assert_equal 3, net.activation_nodes.size
        assert_equal 3, net.activation_nodes.first.size
        assert_equal 3, net.activation_nodes[1].size
        assert_equal 1, net.activation_nodes.last.size
      end
      
      def test_invalid_weights
        assert_raise(Ai4r::NeuralNetwork::InvalidWeightsArrayError) do
          net = Perceptron.new([2, 2, 1], [[[-1.0, -1.0], [-1.0, -1.0]], [[1.0], [-1.0]]]) 
        end
      end
      
      def test_invalid_input
        net = Perceptron.new([2, 2, 1], [[[-1.0, -1.0], [-1.0, -1.0], [1.5, 0.5]], [[1.0], [-1.0], [-0.5]]])
        assert_raise(ArgumentError) do
          net.eval([1, 3, 2])
        end
        assert_raise(ArgumentError) do
          net.eval(1)
        end
      end
      
      def test_eval
        net = Perceptron.new([2, 2, 1], [[[-1.0, -1.0], [-1.0, -1.0], [1.5, 0.5]], [[1.0], [-1.0], [-0.5]]])
        assert_equal [0], net.eval([0, 0])
        assert_equal [1], net.eval([0, 1])
        assert_equal [1], net.eval([1, 0])
        assert_equal [0], net.eval([1, 1])
      end
    end
  end
end