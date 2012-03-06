module Toss
  module Meta
    module ClassMethods
    end
    
    module InstanceMethods
      def set(name, value)
        create_accessor(name)
        Object.send("#{name}=", value)
      end

      def create_method(name, &block)
        Object.send(:define_method, name, &block)
      end

      def create_accessor(name)
        create_method("#{name}=") do |value| 
          $globals =  $globals || {}
          $globals[name] = value
        end
        create_method(name.to_sym) do 
          $globals =  $globals || {}
          $globals[name]
        end
      end
    end
    
    def self.included(receiver)
      receiver.extend ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end

