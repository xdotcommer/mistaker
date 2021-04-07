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
      end
    end

    context 'DROPPED_LETTER' do
      it 'should drop a letter in the text' do
        expect(Mistaker::Name.new('Cathy').mistake(Mistaker::DROPPED_LETTER, 3)).to eq('CATY')
      end
    end

    context 'DOUBLE_LETTER' do
      it 'should drop a letter in the text' do
        expect(Mistaker::Name.new('Cathy').mistake(Mistaker::DOUBLE_LETTER, 3)).to eq('CATHHY')
      end
    end

    context 'MISREAD_LETTER' do
      it 'should drop a letter in the text' do
        expect(Mistaker::Name.new('Cathy').mistake(Mistaker::MISREAD_LETTER, 2)).to eq('CAIHY')
      end
    end

    context 'MISTYPED_LETTER' do
      it 'should drop a letter in the text' do
        expect(Mistaker::Name.new('Cathy').mistake(Mistaker::MISTYPED_LETTER, 4)).to eq('CATHU')
      end
    end

    context 'PLURALIZATION' do
      it 'should drop a letter in the text' do
        expect(Mistaker::Name.new('Cathy').mistake(Mistaker::PLURALIZATION, 3)).to eq('CATHYS')
      end
    end

    context 'MISHEARD_LETTERS' do
      it 'should drop a letter in the text' do
        expect(Mistaker::Name.new('Maximum').mistake(Mistaker::MISHEARD_LETTERS, 2)).to eq('MACKSIMUM')
        expect(Mistaker::Name.new('Clover').mistake(Mistaker::MISHEARD_LETTERS, 3)).to eq('CLOFER')
      end
    end
  end
end
