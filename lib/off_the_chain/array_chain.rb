
module OffTheChain
  ArrayChain = Chain.define(
    *(Array.instance_methods - Object.instance_methods).reject do |name|
      name.to_s.include? '!'
    end.reject do |name|
      [:push,:<<,:[]=,:[]].include?(name)
    end
  )
end
