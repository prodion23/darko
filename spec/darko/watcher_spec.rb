RSpec.describe Darko::Watcher do
  before do
    stub_const('SomeClass', Class.new do
      attr_accessor :data
      def initialize data
        @data = data
      end
    end)
  end

  context 'working with an attribute on an instance' do
    it "can detect an invalid attribute" do
      an_instance = SomeClass.new('adsf')
      expect do
        Darko::Watcher.new(an_instance, :@invalid_instance_variable)
      end.to raise_error(Darko::Error)
    end

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

  context 'watching any changes to an instance' do
    an_instance = SomeClass.new('asdf')
    frank = Darko::Watcher.new(an_instance)
  end
end