RSpec.describe Darko::Origin do

  it 'adds initialized_at to object' do
    a = Object.new
    expect(a.darko_initialized_at).to_not be_nil
  end


end