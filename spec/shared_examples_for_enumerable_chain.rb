
shared_examples "enumerable_chain" do
  let(:words) do
    ['oneword', 'two words', 'many words to work with', 'word with numbers 1,2,3']
  end

  context "when making a single call" do
    describe "#call" do
      let(:chain) { described_class.reject { |str| str.include? ' ' } }
      subject{chain.apply(words)}

      it { is_expected.to eq(['oneword']) }
    end
  end

  context "when making a simple chain" do
    describe "#call" do
      let(:chain) do
        described_class.select { |str| str.include? ' ' }.reject{ |str| str =~ /\d/ }
      end
      subject{chain.apply(words)}

      it { is_expected.to eq(['two words', 'many words to work with']) }
    end
  end

  context "when making a large chain" do
    describe "#call" do
      let(:first_chain) do
        described_class.select { |str| str.include? ' ' }.reject{ |str| str =~ /\d/ }
      end

      let(:second_chain) do
        described_class.map { |str| str.upcase }.map { |str| str.split(' ') }
      end

      let(:chain) do
        (first_chain << second_chain).flat_map{|v| v}.sort.take(2)
      end

      subject{chain.apply(words)}

      it { is_expected.to eq(['MANY', 'TO']) }
    end
  end
end
