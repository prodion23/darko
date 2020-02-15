module Darko
  class Delegator < SimpleDelegator
    alias_method :darko__getobj__, :__getobj__
    def __getobj__
      called
      darko__getobj__
    end

    # Anything we want to do on watcher object access do it here
    def called
      Kernel.puts "Object access or mutation occured: #{Kernel.caller()[1..-1].join("\n")}"
    end
  end
end
