require 'logger'

module Darko
  class Delegator < SimpleDelegator

    def initialize object, log_to_file
      @initialized = false
      @log_to_file = log_to_file
      @logger = log_to_file ? Logger.new(File.new("#{object.class}-#{Time.now.to_i}.darko.log", "w")) : Logger.new(STDOUT)
      super(object)
      @initialized = true
      @logger.debug('Darko delegator initialized')
    end

    alias_method :darko__getobj__, :__getobj__
    # TODO: Differentiate between access and mutation - this should be a filter passed through the watcher init
    def __getobj__
      called(:access) if @initialized # not fan
      darko__getobj__
    end

    def __setobj__ new_obj
      called(:mutation) if @initialized # not fan
      super(new_obj)
    end

    # Anything we want to do on watcher object access do it here
    def called action_type
      begin
        stack_without_darko = Kernel.caller(3..-1).join("\n")
        @logger.debug("Object: #{action_type} detected at: ")
        @logger.debug "\t#{stack_without_darko}"
      rescue
        @logger.error('Unable to collect a stack trace')
      end
    end
  end
end
