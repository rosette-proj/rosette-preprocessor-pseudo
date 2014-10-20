# encoding: UTF-8

require 'spec_helper'

include Rosette::Core
include Rosette::Preprocessors

describe PseudoPreprocessor do
  REVERSE_REPLACE_MAP =
    PseudoPreprocessor::REPLACEMENT_MAP.each_with_object({}) do |(latin_char, reps), ret|
      reps.each_char { |char| ret[char] = latin_char }
    end

  def untranslate(string)
    string.each_char.map do |char|
      if found_char = REVERSE_REPLACE_MAP[char]
        found_char
      else
        char
      end
    end.join
  end

  describe 'self#configure' do
    it 'yields a configurator and returns a preprocessor' do
      preprocessor = PseudoPreprocessor.configure do |config|
        expect(config).to be_a(PseudoPreprocessor::Configurator)
      end

      expect(preprocessor).to be_a(PseudoPreprocessor)
    end
  end

  describe '#process_translation' do
    let(:config) { PseudoPreprocessor::Configurator.new }
    let(:preprocessor) { PseudoPreprocessor.new(config) }
    let(:phrase) { "I'm a little teapot" }
    let(:translation) { Translation.new(nil, :en, phrase) }

    it 'creates a new translation object' do
      preprocessor.process_translation(translation).tap do |new_trans|
        expect(new_trans.object_id).to_not eq(translation.object_id)
      end
    end

    it 'replaces all characters with pseudo-equivalents' do
      preprocessor.process(translation).tap do |new_trans|
        expect(untranslate(new_trans.translation)).to eq("[[#{phrase.downcase}]]")
      end
    end

    it 'does not surround output when asked' do
      config.should_surround(false)

      preprocessor.process(translation).tap do |new_trans|
        expect(untranslate(new_trans.translation)).to eq(phrase.downcase)
      end
    end

    it 'increases the length of the output by the specified percentage' do
      config.should_surround(false)
      config.increase_length_by_percentage(0.6)

      preprocessor.process(translation).tap do |new_trans|
        expect(new_trans.translation.length).to eq(
          phrase.length + (0.6 * phrase.length).ceil + 1  # + 1 for additional space
        )
      end
    end
  end
end
