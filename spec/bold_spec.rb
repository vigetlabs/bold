require "spec_helper"

describe Bold do
  it "allows the setting of api_key" do
    Bold.api_key = "123"
    expect(Bold.api_key).to eq("123")
  end
end
