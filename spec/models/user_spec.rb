require "rails_helper"

describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:api_key) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
    it { should have_many(:favorites) }
  end
end
