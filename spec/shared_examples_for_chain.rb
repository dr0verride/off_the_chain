shared_examples "chain" do

  let(:map_chain) do
    described_class.link(:map) { |val| val * 3 }
  end

  let(:reduce_chain) do
    map_chain.link(:reduce,10) { |sum, num| sum + num }
  end

  let(:reject_chain) do
    described_class.link(:reject) { |val| val.even? }
  end

  let(:input) { [1,2,3,4,5] }

  describe ".new" do
    subject(:chain) { described_class }

    it { expect{ chain.new }.to raise_error(NoMethodError) }
  end

  describe ".link" do
    subject { map_chain.call(input) }

    it { is_expected.to eq([3,6,9,12,15]) }
  end

  describe ".define" do
    subject { described_class.define(:map,:reduce,:reject).instance_methods }

    it { is_expected.to include(:map,:reduce,:reject) }
  end

  describe "#link" do
    subject { reduce_chain.call(input) }

    it { is_expected.to eq(55) }
  end

  describe "#push" do
    subject { map_chain.push(reject_chain).apply(input) }

    it { is_expected.to eq([3,9,15]) }
  end
end
