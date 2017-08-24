require 'rails_helper'

RSpec.describe Test, type: :model do
  it { expect(subject).to respond_to(:test_id) }
  it { expect(subject).to respond_to(:first_name) }

  context 'validations' do
    it { expect(subject).to validate_presence_of(:test_id) }
    it { expect(subject).to validate_presence_of(:first_name) }
  end
end
