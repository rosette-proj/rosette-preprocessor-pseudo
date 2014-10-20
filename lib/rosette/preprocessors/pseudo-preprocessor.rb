# encoding: UTF-8

require 'rosette/preprocessors'

module Rosette
  module Preprocessors

    class PseudoPreprocessor < Preprocessor
      autoload :Configurator, 'rosette/preprocessors/pseudo-preprocessor/configurator'

      REPLACEMENT_MAP = {
        'a' => 'áâäàą',
        'b' => 'βъѣ',
        'c' => 'ç¢',
        'd' => 'δÐ',
        'e' => 'éêëèę',
        'f' => 'ƒ',
        'g' => 'ϱ',
        'h' => 'λн',
        'i' => 'íîïìı',
        'j' => 'J',
        'k' => 'ƙ',
        'l' => 'ℓł',
        'm' => '₥м',
        'n' => 'ñńи',
        'o' => 'óôöòø',
        'p' => 'ƥþ',
        'q' => '9',
        'r' => 'řгя',
        's' => 'ƨś',
        't' => 'ƭт',
        'u' => 'úûüù',
        'v' => 'Ʋѵ',
        'w' => 'ωш',
        'x' => 'ж',
        'y' => '¥ѱý',
        'z' => 'ƺźż'
      }

      LOREM = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam fringilla, " +
        "purus eget fermentum porttitor, massa magna rutrum purus, in placerat massa nulla " +
        "eu velit. Donec rutrum feugiat sagittis. Morbi eu tincidunt nulla. Duis varius aliquam" +
        "metus sodales rutrum. Pellentesque luctus ut justo a cursus. Nunc nec efficitur purus. " +
        "Mauris convallis, sapien at rhoncus porta, nisl tellus vehicula nisi, et ullamcorper " +
        "massa ipsum vel velit. "

      def self.configure
        config = Configurator.new
        yield config if block_given?
        new(config)
      end

      def process_translation(translation)
        new_trans = process_string(translation.translation)

        translation.class.from_h(
          translation.to_h.merge(translation: new_trans)
        )
      end

      def process_string(string)
        extra_chars = replace_chars(get_extra_chars_for(string))
        replaced = replace_chars(string)

        if extra_chars.length > 0
          replaced = "#{replaced} #{extra_chars}"
        end

        if configuration.surround?
          "[[#{replaced}]]"
        else
          replaced
        end
      end

      private

      def get_extra_chars_for(string)
        length = string.length * configuration.length_percentage
        (LOREM * (length.to_f / LOREM.length.to_f).ceil)[0..length]
      end

      def replace_chars(string)
        string.gsub(/([a-zA-Z])/) do
          if chars = REPLACEMENT_MAP[$1.downcase]
            chars[rand(chars.length)]
          else
            $1
          end
        end
      end

      def method_for(object)
        # determine if the object implements the translation interface
        is_trans = object.respond_to?(:translation) &&
          object.class.respond_to?(:from_h) &&
          object.respond_to?(:to_h)

        if is_trans
          :process_translation
        elsif object.is_a?(String)
          :process_string
        end
      end
    end

  end
end
