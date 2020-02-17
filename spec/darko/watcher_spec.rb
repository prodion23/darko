RSpec.describe Darko::Watcher do
  before do
    stub_const('SomeClass', Class.new do
      attr_accessor :data

      def initialize data
        @data = data
      end

      @class_ivar = ''
      class << self
        attr_accessor :class_ivar
      end
    end)

    stub_const('ClassVariables', Class.new do
      @@class_var = 0
      def self.add_instance
        @@class_var += 1
      end
    end)
  end

  context 'instance variables on an instance' do
    it 'can watch a valid attribute' do
      an_instance = SomeClass.new('asf')
      expect do
        Darko::Watcher.new(an_instance, :@data)
      end.to_not raise_error
    end

    it 'will call when attribute is accessed' do
      an_instance = SomeClass.new('asf')
      watcher = Darko::Watcher.new(an_instance, :@data)
      watcher.enable!
      expect(watcher.delegator).to receive(:called).once
      an_instance.data += 'more_data'
    end
  end

  context 'instance variables on a class' do
    it 'doesnt raise an error' do
      expect do
        Darko::Watcher.new(SomeClass, :@class_ivar).enable!
      end.to_not raise_error
    end

    it 'will call when attribute is accessed' do
      frank = Darko::Watcher.new(SomeClass, :@class_ivar)
      frank.enable!
      expect(frank.delegator).to receive(:called).once
      SomeClass.class_ivar += 'asdfasdf'
    end
  end

  context 'class variables' do
    it 'doesnt raise an error' do
      expect do
        Darko::Watcher.new(SomeClass, :@@class_var).enable!
      end.to_not raise_error
    end

    it 'will call when attribute is accessed' do
      frank = Darko::Watcher.new(ClassVariables, :@@class_var)
      frank.enable!
      expect(frank.delegator).to receive(:called).once
      ClassVariables.add_instance
    end
  end
end