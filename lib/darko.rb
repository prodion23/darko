module Darko
  class Error < StandardError; end
end
require_relative './darko/version'
require_relative './darko/watcher'
require_relative './darko/delegator'