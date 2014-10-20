# encoding: UTF-8

module Rosette
  module Preprocessors
    class PseudoPreprocessor

      class Configurator
        attr_reader :applies_to_proc, :length_percentage, :surround

        alias :surround? :surround

        def initialize
          @length_percentage = 0
          @surround = true
        end

        # Does the object passed to this block
        # qualify for pre-processing? You decide.
        def applies_to?(&block)
          @applies_to_proc = block
        end

        # must be between 0 and 1 inclusive
        def increase_length_by_percentage(percentage)
          if percentage >= 0
            @length_percentage = percentage
          else
            raise ArgumentError,
              "length increase percentage must be greater than or equal to zero."
          end
        end

        def should_surround(surround)
          @surround = surround
        end
      end

    end
  end
end
