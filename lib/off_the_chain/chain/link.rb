
module OffTheChain
  class Chain
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
