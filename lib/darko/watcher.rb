module Darko
  class Watcher
    attr_accessor :delegator
    def initialize object, attribute=nil, log_to_file=false
      @object = object
      @attribute = attribute
      @delegator = Darko::Delegator.new(attribute_target, log_to_file)
    end

    # Enabling the Darko::Watcher replaces the object with a Darko::Delegator to spy on mutations
    def enable!
      swap_in_delegator
    end

    # Disabling the Darko::Watcher will reset the object attribute to the original - removing the delegator
    def disable!
      swap_out_delegator
    end

    private

    def swap_out_delegator
      original_obj = @delegator.instance_variable_get(:@delegate_sd_obj)
      @object.send(target_setter_message, @attribute, original_obj)
    end

    def swap_in_delegator
      @object.send(target_setter_message, @attribute, @delegator)
    end

    def class_target?
      @object.is_a?(Class) && @object.class_variables.include?(@attribute)
    end

    # Depending on if the target object is a class or instance changes what message we need to send,
    # some memoization just to avoid  if/elses - I'd like this to live elsewhere
    def target_getter_message
      @_target_getter_message ||= class_target? ? :class_variable_get : :instance_variable_get
    end
    def target_setter_message
      @_target_setter_message ||= class_target? ? :class_variable_set : :instance_variable_set
    end

    def attribute_target
      @object.send(target_getter_message, @attribute)
    end
  end
end