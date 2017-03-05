module OffTheChain
  class Chain
    module MethodMissing
      def self.included(base)
        base.extend(self)
      end

      def method_missing(method_name, *args, &block)
        if !exclude_methods.include?(method_name)
          link(method_name, *args, &block)
        else
          super
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        !exclude_methods.include?(method_name) || super
      end

      private
      def exclude_methods
        @exclude_methods ||= [:new]
      end
    end
  end
end
