RSpec.describe Mistaker::Date do
  before do
    @date = Mistaker::Date.new
  end

  describe "#reformat" do
    context "given an empty string" do
      it 'should raise an error' do
        expect { @date.reformat('') }.to raise_error(::Date::Error)
      end
    end

    context "given an invalid date format" do
      it 'should raise an error' do
        expect { @date.reformat('12-122-41411') }.to raise_error(::Date::Error)
      end
    end

    context "given the expected format" do
      it 'return that format' do
        expect(@date.reformat('1902-12-10')).to eq('1902-12-10')
      end
    end

    context "given the American format" do
      it 'return the preferred format' do
        expect(@date.reformat('12/5/2020')).to eq('2020-12-05')
      end
    end

    context "given the Y2K format" do
      it 'return the preferred format in the 21st century' do
        expect(@date.reformat('5/2/12')).to eq('2012-05-02')
      end
    end
  end

  describe "#mistake" do
    context 'by default, with no arguments' do
      it 'should randomly select a transformation and date portion to apply' do
        expect(Mistaker::Date.new('1988-04-12').mistake).not_to eq('1988-04-12')
        expect(Mistaker::Date.new('2010-09-05').mistake).not_to eq('2010-09-05')
        expect(Mistaker::Date.new('1996-06-07').mistake).not_to eq('1996-06-07')
        expect(Mistaker::Date.new('2018-12-02').mistake).not_to eq('2018-12-02')
      end
    end

    context 'ONE_DIGIT_UP' do
      it 'should increment the appropriate date section' do
        expect(Mistaker::Date.new('2010-12-05').mistake(Mistaker::ONE_DIGIT_UP, Mistaker::Date::DAY)).to eq('2010-12-06')
        expect(Mistaker::Date.new('2010-12-05').mistake(Mistaker::ONE_DIGIT_UP, Mistaker::Date::MONTH)).to eq('2010-13-05')
        expect(Mistaker::Date.new('2010-12-05').mistake(Mistaker::ONE_DIGIT_UP, Mistaker::Date::YEAR)).to eq('2011-12-05')
      end
    end

    context 'ONE_DIGIT_DOWN' do
      it 'should increment the appropriate date section' do
        expect(Mistaker::Date.new('2010-12-05').mistake(Mistaker::ONE_DIGIT_DOWN, Mistaker::Date::DAY)).to eq('2010-12-04')
        expect(Mistaker::Date.new('2010-12-05').mistake(Mistaker::ONE_DIGIT_DOWN, Mistaker::Date::MONTH)).to eq('2010-11-05')
        expect(Mistaker::Date.new('2010-12-05').mistake(Mistaker::ONE_DIGIT_DOWN, Mistaker::Date::YEAR)).to eq('2009-12-05')
      end
    end

    context 'ONE_DECADE_DOWN' do
      it 'should increment the appropriate date section' do
        expect(Mistaker::Date.new('2010-12-05').mistake(Mistaker::ONE_DECADE_DOWN)).to eq('2000-12-05')
      end
    end

    context 'Y2K' do
      it 'should change the century to 1000 or 2000 BC' do
        expect(Mistaker::Date.new('2015-12-05').mistake(Mistaker::Y2K)).to eq('0015-12-05')
        expect(Mistaker::Date.new('1915-12-05').mistake(Mistaker::Y2K)).to eq('2015-12-05')
      end
    end

    context 'MONTH_DAY_SWAP' do
      it 'should change the century to 1000 or 2000 BC' do
        expect(Mistaker::Date.new('2010-05-12').mistake(Mistaker::MONTH_DAY_SWAP)).to eq('2010-12-05')
        expect(Mistaker::Date.new('2010-03-09').mistake(Mistaker::MONTH_DAY_SWAP)).to eq('2010-09-03')
      end
    end

    context 'KEY_SWAP' do
      it 'should swap the last two digits' do
        expect(Mistaker::Date.new('1934-02-21').mistake(Mistaker::KEY_SWAP, Mistaker::Date::DAY)).to eq('1934-02-12')
        expect(Mistaker::Date.new('1934-02-08').mistake(Mistaker::KEY_SWAP, Mistaker::Date::MONTH)).to eq('1934-20-08')
        expect(Mistaker::Date.new('1934-12-05').mistake(Mistaker::KEY_SWAP, Mistaker::Date::YEAR)).to eq('1943-12-05')
      end
    end

    context 'DIGIT_SHIFT' do
      it 'should shift the digits over with two zeros' do
        expect(Mistaker::Date.new('2010-05-12').mistake(Mistaker::DIGIT_SHIFT)).to eq('0020-10-05')
        expect(Mistaker::Date.new('1945-03-09').mistake(Mistaker::DIGIT_SHIFT)).to eq('0019-45-03')
      end
    end

    context 'MISREAD' do
      it 'should change the numbers to numbers that look like them when handwritten' do
        expect(Mistaker::Date.new('2010-05-12').mistake(Mistaker::MISREAD, Mistaker::Date::DAY)).to eq('2010-05-15')
        expect(Mistaker::Date.new('2010-05-09').mistake(Mistaker::MISREAD, Mistaker::Date::DAY)).to eq('2010-05-04')
        expect(Mistaker::Date.new('2010-05-23').mistake(Mistaker::MISREAD, Mistaker::Date::DAY)).to eq('2010-05-28')
        expect(Mistaker::Date.new('2010-04-12').mistake(Mistaker::MISREAD, Mistaker::Date::MONTH)).to eq('2010-09-12')
        expect(Mistaker::Date.new('2010-06-09').mistake(Mistaker::MISREAD, Mistaker::Date::MONTH)).to eq('2010-05-09')
        expect(Mistaker::Date.new('2010-07-23').mistake(Mistaker::MISREAD, Mistaker::Date::MONTH)).to eq('2010-01-23')
        expect(Mistaker::Date.new('1942-07-21').mistake(Mistaker::MISREAD, Mistaker::Date::YEAR)).to eq('1992-07-21')
        expect(Mistaker::Date.new('1925-07-21').mistake(Mistaker::MISREAD, Mistaker::Date::YEAR)).to eq('1955-07-21')
        expect(Mistaker::Date.new('2005-07-21').mistake(Mistaker::MISREAD, Mistaker::Date::YEAR)).to eq('2085-07-21')
      end
    end

    context 'NUMERIC_KEY_PAD' do
      it 'should change the numbers to numbers that were mistyped on a ten key pad' do
        expect(Mistaker::Date.new('2010-05-12').mistake(Mistaker::NUMERIC_KEY_PAD, Mistaker::Date::DAY)).to eq('2010-05-15')
        expect(Mistaker::Date.new('2010-05-09').mistake(Mistaker::NUMERIC_KEY_PAD, Mistaker::Date::DAY)).to eq('2010-05-06')
        expect(Mistaker::Date.new('2010-05-23').mistake(Mistaker::NUMERIC_KEY_PAD, Mistaker::Date::DAY)).to eq('2010-05-26')
        expect(Mistaker::Date.new('2010-04-12').mistake(Mistaker::NUMERIC_KEY_PAD, Mistaker::Date::MONTH)).to eq('2010-01-12')
        expect(Mistaker::Date.new('2010-06-09').mistake(Mistaker::NUMERIC_KEY_PAD, Mistaker::Date::MONTH)).to eq('2010-03-09')
        expect(Mistaker::Date.new('2010-07-23').mistake(Mistaker::NUMERIC_KEY_PAD, Mistaker::Date::MONTH)).to eq('2010-04-23')
        expect(Mistaker::Date.new('1942-07-21').mistake(Mistaker::NUMERIC_KEY_PAD, Mistaker::Date::YEAR)).to eq('1945-07-21')
        expect(Mistaker::Date.new('1925-07-21').mistake(Mistaker::NUMERIC_KEY_PAD, Mistaker::Date::YEAR)).to eq('1922-07-21')
        expect(Mistaker::Date.new('2000-07-21').mistake(Mistaker::NUMERIC_KEY_PAD, Mistaker::Date::YEAR)).to eq('2001-07-21')
      end
    end
  end
end
