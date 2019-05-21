require 'spec_helper'

module EmaAlgo
  RSpec.describe EmaVersion2 do
    subject { described_class.new(params) }

    let(:params) do
      {
        low_price: 10.0,
        high_price: 15.0,
        small_ema: small_ema,
        medium_ema: medium_ema,
        long_ema: long_ema,
        exit_ema: exit_ema,
      }
    end

    let(:small_ema) { 12.5 }
    let(:medium_ema) { 9.5 }
    let(:long_ema) { 7.5 }
    let(:exit_ema) { 15.0 }

    describe '#apply' do
      context 'long signal' do
        it 'signals long' do
          expect(subject.apply).to eq('long')
        end
      end

      context 'short signal' do
        let(:small_ema) { 10.5 }
        let(:medium_ema) { 18.5 }
        let(:long_ema) { 16.5 }
        let(:exit_ema) { 7.5 }

        it 'signals short' do
          expect(subject.apply).to eq('short')
        end
      end

      context 'exit long' do
        let(:small_ema) { 10.5 }
        let(:medium_ema) { 18.5 }
        let(:long_ema) { 9.5 }
        let(:exit_ema) { 7.5 }

        it 'signals exit long' do
          expect(subject.apply).to eq('exit_long')
        end
      end

      context 'exit short' do
        let(:small_ema) { 15.5 }
        let(:medium_ema) { 12.5 }
        let(:long_ema) { 9.5 }
        let(:exit_ema) { 15.5 }

        it 'signals exit short' do
          expect(subject.apply).to eq('exit_short')
        end
      end
    end
  end
end
