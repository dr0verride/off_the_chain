require 'forwardable'

module OffTheChain
  class Chain
    extend Forwardable

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

    def link(method_name, *args, &block)
      push(parse_link(method_name,*args,&block))
    end

    def self.link(method_name, *args, &block)
      new([parse_link(method_name,*args,&block)])
    end

    def self.define(*method_names)
      m = Module.new do
        method_names.map(&:to_sym).each do |name|
          define_method(name) do |*args,&block|
            link(name,*args,&block)
          end
        end
      end

      Class.new(self) do
        include m
        extend m
      end
    end

    private
    attr_reader :chain_links
    private_class_method :new

    def initialize(chain_links)
      @chain_links = chain_links
    end

    def self.parse_link(method_name, *args, &block)
      case method_name
      when Symbol, String
        Link.new(method_name, *args, &block)
      when RespondTo[:call]
        raise ArgumentError.new("Callable chain links must be arity (1)") unless method_name.arity == 1
        method_name
      else
        raise ArgumentError.new("Chain links must be arguments to a #send message or callable")
      end
    end

    def_delegator self, :parse_link

    class Link
      def initialize(op, *args, &block)
        @op = op
        @args = args
        @block = block
      end

      def call(subject)
        subject.public_send(op,*args,&block)
      end

      private
      attr_reader :op, :args, :block
    end
  end
end

