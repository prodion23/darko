RSpec.describe Darko::Watcher do
  before do
    stub_const('SomeClass', Class.new)
  end

  it "can detect an invalid attribute" do
    an_instance = SomeClass.new
    expect do
      Darko::Watcher.new(an_instance, :@invalid_instance_variable)
    end.to raise_error(Darko::Error)
  end
end