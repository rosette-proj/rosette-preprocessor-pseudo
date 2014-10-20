# encoding: UTF-8

require 'spec_helper'

include Rosette::Preprocessors

describe PseudoPreprocessor::Configurator do
  let(:configurator) { PseudoPreprocessor::Configurator.new }

  describe '#applies_to?' do
    it 'sets applies_to_proc' do
      configurator.applies_to? { :applies_to }
      expect(configurator.applies_to_proc).to_not be_nil
      expect(configurator.applies_to_proc.call).to eq(:applies_to)
    end
  end

  describe '#increase_length_by_percentage' do
    it 'sets the percentage length increase in the configurator' do
      configurator.increase_length_by_percentage(0.6)
      expect(configurator.length_percentage).to eq(0.6)
    end

    it 'raises an error if the length increase is less than zero' do
      expect { configurator.increase_length_by_percentage(-0.5) }.to(
        raise_error(ArgumentError)
      )
    end
  end

  describe '#should_surround' do
    it 'sets surround in the configurator' do
      configurator.should_surround(true)
      expect(configurator.surround?).to eq(true)
    end
  end
end
