RSpec.describe Mistaker::Number do
  describe "#mistake" do
    context 'by default, with no arguments' do
      it 'should randomly select a transformation to apply' do
        expect(Mistaker::Number.new('2018122').mistake).not_to eq('2018122')
      end
    end

    context 'ONE_DIGIT_UP' do
      it 'should increment a digit by one' do
        expect(Mistaker::Number.new('198012').mistake(Mistaker::ONE_DIGIT_UP, 5)).to eq('198013')
        expect(Mistaker::Number.new('201005').mistake(Mistaker::ONE_DIGIT_UP, 0)).to eq('301005')
        expect(Mistaker::Number.new('28122').mistake(Mistaker::ONE_DIGIT_UP, 2)).to eq('28222')
      end
    end

    context 'ONE_DIGIT_DOWN' do
      it 'should decrement a digit by one' do
        expect(Mistaker::Number.new('198012').mistake(Mistaker::ONE_DIGIT_DOWN, 5)).to eq('198011')
        expect(Mistaker::Number.new('201005').mistake(Mistaker::ONE_DIGIT_DOWN, 0)).to eq('101005')
        expect(Mistaker::Number.new('28122').mistake(Mistaker::ONE_DIGIT_DOWN, 2)).to eq('28022')
      end
    end

    context 'KEY_SWAP' do
      it 'should swap the two of the digits' do
        expect(Mistaker::Number.new('2006780').mistake(Mistaker::KEY_SWAP, 4)).to eq('2007680')
        expect(Mistaker::Number.new('12345').mistake(Mistaker::KEY_SWAP, 0)).to eq('21345')
        expect(Mistaker::Number.new('12345').mistake(Mistaker::KEY_SWAP, 4)).to eq('12354')
      end
    end

    context 'DIGIT_SHIFT' do
      it 'should pad the entry with a number of zeros' do
        expect(Mistaker::Number.new('12345').mistake(Mistaker::DIGIT_SHIFT, 2)).to eq('00123')
        expect(Mistaker::Number.new('01234').mistake(Mistaker::DIGIT_SHIFT, 2)).to eq('00012')
        expect(Mistaker::Number.new('45645').mistake(Mistaker::DIGIT_SHIFT, 8)).to eq('00000')
        expect(Mistaker::Number.new('45645').mistake(Mistaker::DIGIT_SHIFT, 4)).to eq('00004')
      end
    end

    context 'MISREAD' do
      it 'should change the numbers to numbers that look like them when handwritten' do
        expect(Mistaker::Number.new('010012').mistake(Mistaker::MISREAD, 5)).to eq('010015')
        expect(Mistaker::Number.new('010009').mistake(Mistaker::MISREAD, 5)).to eq('010004')
        expect(Mistaker::Number.new('010023').mistake(Mistaker::MISREAD, 5)).to eq('010028')
        expect(Mistaker::Number.new('942021').mistake(Mistaker::MISREAD, 1)).to eq('992021')
        expect(Mistaker::Number.new('925021').mistake(Mistaker::MISREAD, 1)).to eq('955021')
        expect(Mistaker::Number.new('005021').mistake(Mistaker::MISREAD, 1)).to eq('085021')
      end
    end

    context 'NUMERIC_KEY_PAD' do
      it 'should change swap out a number based on numeric keypad entry' do
        expect(Mistaker::Number.new('010012').mistake(Mistaker::NUMERIC_KEY_PAD, 5)).to eq('010015')
        expect(Mistaker::Number.new('010009').mistake(Mistaker::NUMERIC_KEY_PAD, 5)).to eq('010006')
        expect(Mistaker::Number.new('010023').mistake(Mistaker::NUMERIC_KEY_PAD, 5)).to eq('010026')
        expect(Mistaker::Number.new('942021').mistake(Mistaker::NUMERIC_KEY_PAD, 1)).to eq('912021')
        expect(Mistaker::Number.new('925021').mistake(Mistaker::NUMERIC_KEY_PAD, 1)).to eq('955021')
        expect(Mistaker::Number.new('005021').mistake(Mistaker::NUMERIC_KEY_PAD, 1)).to eq('015021')
      end
    end
  end
end
