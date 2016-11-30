require 'item'

describe Item do

  subject(:item) { described_class.new("Item", 1, 5)}

  it 'is initialized with a name, value and quality' do
    expect(subject.to_s).to eq "Item, 1, 5"
  end

end
