require 'support/model'
require 'pesel_validator'

describe PeselValidator do

  before do
    Model.validates :field, pesel: true
  end

  let(:invalid_pesel){'00000000000'}
  let(:valid_pesel){'75120804355'}

  it 'is not valid when pesel is invalid' do
    model = Model.new
    model.field = invalid_pesel
    expect(model).to_not be_valid
  end

  it 'is valid when pesel is valid' do
    model = Model.new
    model.field = valid_pesel
    expect(model).to be_valid
  end
end