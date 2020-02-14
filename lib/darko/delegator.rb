module Darko
  class Delegator < SimpleDelegator
    alias_method :darko__getobj__, :__getobj__
    def __getobj__
      Kernel.puts "Object access or mutation occured: #{Kernel.caller()[1..-1].join("\n")}"
      darko__getobj__
    end
  end
end
