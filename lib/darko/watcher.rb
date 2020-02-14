module Darko
  class Watcher
    def initialize object, instance_variable
      raise Darko::Error.new("Attribute #{instance_variable} doesnt exist on #{object}") unless object.instance_variable_get(instance_variable)
      @object = object
      @instance_variable = instance_variable
      @delegator = nil
    end

    # Enabling the Darko::Watcher replaces the object with a Darko::Delegator to spy on mutations
    def enable!
      @delegator = Darko::Delegator.new(@object.instance_variable_get(@instance_variable))
      @object.instance_variable_set(@instance_variable, @delegator)
    end

    # Disabling the Darko::Watcher will reset the object attribute to the original - removing the delegator
    def disable!
      original_object = @delegator.instance_variable_get(:@delegate_sd_obj)
      @object.instance_variable_set(@instance_variable, original_object)
    end
  end
end