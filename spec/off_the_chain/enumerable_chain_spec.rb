require 'spec_helper'

require 'shared_examples_for_chain'
require 'shared_examples_for_enumerable_chain'

describe OffTheChain::EnumerableChain do
  it_behaves_like 'chain'
  it_behaves_like 'enumerable_chain'
end
