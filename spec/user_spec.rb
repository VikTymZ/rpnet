require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { described_class.new(email: "test@email.net", first_name: "random", last_name: "guy", password: "simplepass", password_confirmation: "simplepass") }

  it "is not valid with valid parameter" do
    expect(subject).to be_valid
  end

  it "is not valid without first name" do
    expect(subject).to be_valid
  end
end
