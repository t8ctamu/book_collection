require "rails_helper"

RSpec.describe "Seeded test database", type: :model do
  before do
    Rails.application.load_seed
  end

  it "loads all five test books into the test database" do
    expect(Rails.env).to eq("test")
    expect(Book.where(title: [
      "Test Book One", "Test Book Two", "Test Book Three", "Test Book Four", "Test Book Five"
    ]).count).to eq(5)
  end

  it "does not duplicate books when seeds run again" do
    expect { Rails.application.load_seed }.not_to change(Book, :count)
  end
end
