require 'spec_helper'

describe Spa::Demo::Test::Suite do
  it 'has a version number' do
    expect(Spa::Demo::Test::Suite::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(true).to eq(true)
  end
end
