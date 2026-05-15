# Require the file where your caesar_cipher method lives. 
# Adjust the path if your file is named differently.
require_relative '../caesar_cipher'

describe '#caesar_cipher' do
  it 'shifts characters by the given amount (standard shift)' do
    expect(caesar_cipher('What a string!', 5)).to eq('Bmfy f xywnsl!')
  end

  it 'wraps from z to a correctly' do
    expect(caesar_cipher('Z', 1)).to eq('A')
    expect(caesar_cipher('z', 2)).to eq('b')
  end

  it 'maintains character casing' do
    expect(caesar_cipher('AaBbCc', 2)).to eq('CcDdEe')
  end

  it 'leaves punctuation and spaces untouched' do
    expect(caesar_cipher('Hello, World! 123', 5)).to eq('Mjqqt, Btwqi! 123')
  end

  it 'handles negative shifts correctly' do
    # Shifting backward by 5 should undo the first test
    expect(caesar_cipher('Bmfy f xywnsl!', -5)).to eq('What a string!')
  end

  it 'handles shifts greater than 26' do
    # A shift of 27 is identical to a shift of 1
    expect(caesar_cipher('Hello', 27)).to eq('Ifmmp')
  end
end