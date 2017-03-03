
module OffTheChain
  EnumerableChain = Chain.define(*Enumerable.instance_methods.reject { |name| name.to_s.include? '!' })
end
