require 'rails_helper'

RSpec.describe Food, type: :model do
  it 'is valid with valid attributes' do
    food = build(:food)
    expect(food).to be_valid
  end
end
