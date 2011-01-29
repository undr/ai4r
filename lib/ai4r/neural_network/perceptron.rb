require File.dirname(__FILE__) + '/../data/parameterizable' 
module Ai4r
  
  # Artificial Neural Networks are mathematical or computational models based on 
  # biological neural networks. 
  # 
  # More about neural networks:
  # 
  # * http://en.wikipedia.org/wiki/Artificial_neural_network
  #
  module NeuralNetwork
    
    # = Introduction
    # 
    # 
    # = Features
    # 
    # 
    # = Parameters
    # 
    # Use class method get_parameters_info to obtain details on the algorithm
    # parameters. Use set_parameters to set values for this parameters.
    # 
    # 
    # = How to use it
    # See ai4r/examples/neural_network/perceptron_xor_example.rb
    #     
    # More about perceptron neural networks:
    # 
    # * http://en.wikipedia.org/wiki/perceptron
    # 
    # = About the project
    # Author::    Sergio Fierens
    # License::   MPL 1.1
    # Url::       http://ai4r.rubyforge.org
    class InvalidWeightsArrayError < ::StandardError; end
    class Perceptron
      
      include Ai4r::Data::Parameterizable
          
      parameters_info :activation_function => "By default: lambda { |x| x >= 0 ? 1 : 0 }", 
                      :initial_value => "By default: 0.0"
      attr_accessor :structure, :weights, :activation_nodes
      
      def initialize(network_structure, weights)
        @structure = network_structure
        @activation_function = lambda { |x| x >= 0 ? 1 : 0 }
        @activation_nodes = []
        @initial_value = 0.0
        init_activation_nodes!
        init_weights!(weights)
      end

      def eval(inputs)
        check_input_dimension!(inputs.size)
        init_activation_nodes!(inputs)
        propagate!
        check_output_dimension(@activation_nodes.last.size)
        @activation_nodes.last
      end
      
      private
      def propagate!
        @weights.each_index do |n|
          @structure[n+1].times do |j|
            sum = 0.0
            @activation_nodes[n].each_index do |i|
              sum += (@activation_nodes[n][i] * @weights[n][i][j])
            end
            @activation_nodes[n+1][j] = @activation_function.call(sum)
          end
        end
      end
      
      def init_weights!(weights)
        @weights = Array.new(@structure.length-1) do |i|
          nodes_origin = @activation_nodes[i].length
          nodes_target = @structure[i+1]
          Array.new(nodes_origin) do |j|
            Array.new(nodes_target) do |k| 
              weights[i][j][k]
            end
          end
        end
      rescue
        raise InvalidWeightsArrayError
      end
      
      def init_activation_nodes!(input_values=nil)
        @activation_nodes = Array.new(@structure.length) do |n| 
          Array.new(@structure[n], @initial_value)
        end
        @activation_nodes[0...-1].each {|layer| layer << 1.0 }
        input_values.each_index do |input_index| 
          @activation_nodes.first[input_index] = input_values[input_index]
        end if input_values
      end
      
      def check_input_dimension!(inputs)
        raise ArgumentError, "Wrong number of inputs. " +
          "Expected: #{@structure.first}, " +
          "received: #{inputs}." if inputs != @structure.first
      end
      
      def check_output_dimension(outputs)
        raise ArgumentError, "Wrong number of outputs. " +
          "Expected: #{@structure.last}, " +
          "received: #{outputs}." if outputs != @structure.last
      end
    end
  end
end