RSpec.describe Mistaker::Name do
  before do
    @mistaker = Mistaker::Name.new
  end

  describe "#reformat" do
    context "given mixed case" do
      it 'should make everything uppercase' do
        expect(@mistaker.reformat('Apollo Theatre')).to eq('APOLLO THEATRE')
      end
    end

    context "given non alpha characters" do
      it 'should strip those characters' do
        expect(@mistaker.reformat('Mr. Nathaniel Wright')).to eq('MR NATHANIEL WRIGHT')
      end
    end
  end

  describe "#mistake" do
    context 'by default, with no arguments' do
      it 'should randomly select a transformation to apply' do
        expect(Mistaker::Name.new('Cathy').mistake).not_to eq('Cathy')
        expect(Mistaker::Name.new('Martin').mistake).not_to eq('Martin')
      end
    end

    context 'DROPPED_LETTER' do
      it 'should drop a letter in the text' do
        expect(Mistaker::Name.new('Cathy').mistake(Mistaker::DROPPED_LETTER, 3)).to eq('CATY')
      end
    end

    context 'DOUBLE_LETTER' do
      it 'should double enter a letter' do
        expect(Mistaker::Name.new('Cathy').mistake(Mistaker::DOUBLE_LETTER, 3)).to eq('CATHHY')
      end
    end

    context 'MISREAD_LETTER' do
      it 'should replace a letter with something looking similar when handwritten' do
        expect(Mistaker::Name.new('Cathy').mistake(Mistaker::MISREAD_LETTER, 2)).to eq('CAIHY')
        expect(Mistaker::Name.new(' ').mistake(Mistaker::MISREAD_LETTER, 0)).to eq(' ')
      end
    end

    context 'MISTYPED_LETTER' do
      it 'should replace letters with a commonly mistyped letter' do
        expect(Mistaker::Name.new('Cathy').mistake(Mistaker::MISTYPED_LETTER, 4)).to eq('CATHU')
        expect(Mistaker::Name.new(' ').mistake(Mistaker::MISTYPED_LETTER, 0)).to eq(' ')
      end
    end

    context 'EXTRA_LETTER' do
      it 'should add an extra letter to the end of the word' do
        expect(Mistaker::Name.new('DRUM').mistake(Mistaker::EXTRA_LETTER)).to eq('DRUMN')
        expect(Mistaker::Name.new('CART').mistake(Mistaker::EXTRA_LETTER)).to eq('CARTT')
        expect(Mistaker::Name.new('CATALOG').mistake(Mistaker::EXTRA_LETTER)).to eq('CATALOGUE')
        expect(Mistaker::Name.new('TRAP').mistake(Mistaker::EXTRA_LETTER)).to eq('TRAPH')
        expect(Mistaker::Name.new('MATE').mistake(Mistaker::EXTRA_LETTER)).to eq('MATES')
        expect(Mistaker::Name.new('MAD').mistake(Mistaker::EXTRA_LETTER)).to eq('MADT')
        expect(Mistaker::Name.new('MAC').mistake(Mistaker::EXTRA_LETTER)).to eq('MACE')
        expect(Mistaker::Name.new('RAY').mistake(Mistaker::EXTRA_LETTER)).to eq('RAYS')
        expect(Mistaker::Name.new('TAZ').mistake(Mistaker::EXTRA_LETTER)).to eq('TAZE')
      end
    end

    context 'MISHEARD_LETTERS' do
      it 'should replace letters with something sounding similar' do
        expect(Mistaker::Name.new('Maximum').mistake(Mistaker::MISHEARD_LETTERS, 2)).to eq('MACKSIMUM')
        expect(Mistaker::Name.new('Clover').mistake(Mistaker::MISHEARD_LETTERS, 3)).to eq('CLOFER')
        expect(Mistaker::Name.new(' ').mistake(Mistaker::MISHEARD_LETTERS, 3)).to eq(' ')
      end
    end
  end
end
