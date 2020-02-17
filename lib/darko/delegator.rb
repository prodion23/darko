module Darko
  class Delegator < SimpleDelegator
    alias_method :darko__getobj__, :__getobj__
    def __getobj__
      called
      darko__getobj__
    end

    # Anything we want to do on watcher object access do it here
    def called
      stack_without_darko = Kernel.caller(3..-1).join("\n")
      Kernel.puts "Object access or mutation occurred: "
      Kernel.puts "#{stack_without_darko}"
    end
  end
end
