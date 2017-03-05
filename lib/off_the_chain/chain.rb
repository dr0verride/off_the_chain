require 'forwardable'

require 'off_the_chain/chain/method_missing'
require 'off_the_chain/chain/link'

module OffTheChain
  class Chain
    extend Forwardable
    include MethodMissing

    def call(subject)
      chain_links.reduce(subject) do |subj, a_link|
        a_link.call(subj)
      end
    end

    alias_method :apply, :call
    alias_method :[], :call

    def push(chain)
      self.class.send(:new,[*chain_links, chain])
    end

    alias_method :<<, :push

    def to_s
      "#{self.class.name}(\n#{chain_links})\n"
    end

    alias_method :inspect, :to_s

    def link(*args, &block)
      push(parse_link(*args,&block))
    end

    def self.link(*args, &block)
      new([parse_link(*args,&block)])
    end

    private
    attr_reader :chain_links
    private_class_method :new

    def initialize(chain_links)
      @chain_links = chain_links
    end

    def self.parse_link(*args, &block)
      method_name = args.shift
      case method_name
      when Symbol, String
        Link.new(method_name, *args, &block)
      else
        if method_name.respond_to?(:call)
          raise ArgumentError.new("Callable chain links must be arity (1)") unless method_name.arity == 1
          method_name
        elsif method_name.nil? && !block.nil?
          raise ArgumentError.new("Callable chain links must be arity (1)") unless block.arity == 1
          block
        else
          raise ArgumentError.new("Chain links must be arguments to a #send message or callable")
        end
      end
    end

    def_delegator self, :parse_link
  end
end

