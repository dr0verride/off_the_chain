require 'spec_helper'
require 'byebug'

require 'shared_examples_for_chain'
require 'shared_examples_for_enumerable_chain'

describe OffTheChain::Chain do
  it_behaves_like 'enumerable_chain'
  it_behaves_like 'chain'
end
