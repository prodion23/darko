module Darko
  class Error < StandardError; end
end
require 'singleton'
require_relative './darko/version'
require_relative './darko/watcher'
require_relative './darko/delegator'

class Foo
  attr_accessor :data
  def initialize data
    @data = data
  end

  def add_data something
    @data << something
  end
end