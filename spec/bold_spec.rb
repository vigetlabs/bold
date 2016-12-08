require "spec_helper"

describe Bold do
  it "allows the setting of api_key" do
    Bold.api_key = "123"
    expect(Bold.api_key).to eq("123")
  end

  it "allows the setting of api_url" do
    Bold.api_url = "https://api.gobold.com"
    expect(Bold.api_url).to eq("https://api.gobold.com/v1")
  end
end
