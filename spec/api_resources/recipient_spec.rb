require "spec_helper"

describe Bold::Recipient do
  before do
    Bold.api_key = "5hWqzjC1B7udHWgE440YsHM7gH9IWjRbkL9XOyNoDpwm0U49sRTrarJwJwFd50TCNEGExnKRaHCRL2ItrpabfnPgY5"
    Bold.api_url = "https://api-sandbox.gobold.com"
  end

  describe ".create" do
    it "can create resources" do
      VCR.use_cassette("recipient-create") do
        recipient = Bold::Recipient.create({
          remote_id: "test-slug",
          type:      "individual",
          email:     "test-user@example.com"
        })

        expect(recipient.id).to                       eq("584982781a336208003c745d")
        expect(recipient.kyc_level).to                eq(0)
        expect(recipient.requires_kyc_level).to       eq(2)
        expect(recipient.locale).to                   eq("en_US")
        expect(recipient.remote_id).to                eq("test-slug")
        expect(recipient.primary_wallet_id).to        eq(nil)
        expect(recipient.status).to                   eq("active")
        expect(recipient.verified).to                 eq("new")
        expect(recipient.type).to                     eq("individual")
        expect(recipient.name).to                     eq("")
        expect(recipient.first_name).to               eq("")
        expect(recipient.last_name).to                eq("")
        expect(recipient.email).to                    eq("test-user@example.com")
        expect(recipient.registration_office).to      eq("")
        expect(recipient.occupation).to               eq("")
        expect(recipient.facebook).to                 eq("")
        expect(recipient.revenue).to                  eq("")
        expect(recipient.legal_structure).to          eq("")
        expect(recipient.industry).to                 eq("")
        expect(recipient.place_of_birth).to           eq("")
        expect(recipient.nationality).to              eq("")
        expect(recipient.gender).to                   eq("")
        expect(recipient.country).to                  eq("US")
        expect(recipient.description).to              eq("")
        expect(recipient.address).to                  eq("")
        expect(recipient.city).to                     eq("")
        expect(recipient.state).to                    eq("")
        expect(recipient.postalcode).to               eq("")
        expect(recipient.tags).to                     eq("")
        expect(recipient.dob_year).to                 eq("")
        expect(recipient.dob_month).to                eq("")
        expect(recipient.dob_day).to                  eq("")
        expect(recipient.ofac_at).to                  eq("")
        expect(recipient.created_at).to               eq(1481212536)
        expect(recipient.updated_at).to               eq(1481212536)
        expect(recipient.accepted_terms).to           eq(false)
        expect(recipient.onboard_step).to             eq("step1")
        expect(recipient.onboard).to                  eq("pending")
        expect(recipient.onboard_at).to               eq("")
        expect(recipient.restricted_international).to eq(false)
        expect(recipient.onboarding_url).to           eq("https://onboarding-sandbox.gobold.com/onboardlink?token=YTZkYjcxYzJiMzA1NzZkNWQxODgzM2Y5MDk2MjNmMTIzODZlNGRmY1UyRnNkR1ZrWDEvRjJWK2JUQXZhZjdZRnhlWGdkeE9QcjFWbVN6REpGR2lXUXkvMW9BdXd2Z29wcGxaZE1hOEdwVHF0OU5jMlZWcE9iNFFXMDZyaStrY0lpRXRmRUhzTGtyTmEzYjVUeldhR3FacVZDZkdsRjVvRFhPNC9mdTl1b0hkSldPME1nbzREekxqRVpjMUZOcFFBS21LYUNtQU5qYmlEcFdZZ2duWjdYN0N5STJHczRlV0krTDU0emhvbg")
      end
    end

    it "handles invalid input gracefully" do
      VCR.use_cassette("bad-recipient-create") do
        begin
          recipient = Bold::Recipient.create({
            remote_id: "test-slug",
            type:      "individual",
            email:     "test-user@example.com" # using an existing email
          })
        rescue => error
          @error = error
        end

        expect(@error).to be_a Bold::UnprocessableEntity
        expect(@error.message).to eq('Input failed validation. {"email"=>{"messages"=>["Email is already in use."]}}')
      end
    end
  end

  describe ".find" do
    it "can find a resource" do
      VCR.use_cassette("recipient-find") do
        recipient = Bold::Recipient.find("5848a14e4427b9090041ccde")

        expect(recipient.id).to                       eq("5848a14e4427b9090041ccde")
        expect(recipient.kyc_level).to                eq(0)
        expect(recipient.requires_kyc_level).to       eq(2)
        expect(recipient.locale).to                   eq("en_US")
        expect(recipient.remote_id).to                eq("eli-fat")
        expect(recipient.primary_wallet_id).to        eq("5848a1e4ae6b830700d8ad88")
        expect(recipient.status).to                   eq("active")
        expect(recipient.verified).to                 eq("verified")
        expect(recipient.type).to                     eq("individual")
        expect(recipient.name).to                     eq("")
        expect(recipient.first_name).to               eq("Eli")
        expect(recipient.last_name).to                eq("Fatsi")
        expect(recipient.email).to                    eq("eli@example.com")
        expect(recipient.registration_office).to      eq("")
        expect(recipient.occupation).to               eq("")
        expect(recipient.facebook).to                 eq("")
        expect(recipient.revenue).to                  eq("")
        expect(recipient.legal_structure).to          eq("")
        expect(recipient.industry).to                 eq("")
        expect(recipient.place_of_birth).to           eq("")
        expect(recipient.nationality).to              eq("")
        expect(recipient.gender).to                   eq("")
        expect(recipient.country).to                  eq("US")
        expect(recipient.description).to              eq("")
        expect(recipient.address).to                  eq("123 Fake St")
        expect(recipient.city).to                     eq("Boulder")
        expect(recipient.state).to                    eq("CO")
        expect(recipient.postalcode).to               eq("80123")
        expect(recipient.tags).to                     eq("")
        expect(recipient.dob_year).to                 eq(1990)
        expect(recipient.dob_month).to                eq(6)
        expect(recipient.dob_day).to                  eq(12)
        expect(recipient.ofac_at).to                  eq(1481154927)
        expect(recipient.created_at).to               eq(1481154894)
        expect(recipient.updated_at).to               eq(1481154927)
        expect(recipient.accepted_terms).to           eq(true)
        expect(recipient.onboard_step).to             eq("success")
        expect(recipient.onboard).to                  eq("complete")
        expect(recipient.onboard_at).to               eq(1481154904)
        expect(recipient.restricted_international).to eq(false)
      end
    end

    it "handles an invalid id gracefully" do
      VCR.use_cassette("recipient-invalid-find") do
        expect {
          recipient = Bold::Recipient.find("oh-boy")
        }.to raise_error(Bold::ApiError)
      end
    end
  end

  describe ".list" do
    it "can list resources" do
      VCR.use_cassette("recipient-list") do
        recipients = Bold::Recipient.list
        recipient  = recipients.first

        expect(recipient.id).to                       eq("5848a14e4427b9090041ccde")
        expect(recipient.kyc_level).to                eq(0)
        expect(recipient.requires_kyc_level).to       eq(2)
        expect(recipient.locale).to                   eq("en_US")
        expect(recipient.remote_id).to                eq("eli-fat")
        expect(recipient.primary_wallet_id).to        eq("5848a1e4ae6b830700d8ad88")
        expect(recipient.status).to                   eq("active")
        expect(recipient.verified).to                 eq("verified")
        expect(recipient.type).to                     eq("individual")
        expect(recipient.name).to                     eq("")
        expect(recipient.first_name).to               eq("Eli")
        expect(recipient.last_name).to                eq("Fatsi")
        expect(recipient.email).to                    eq("eli@example.com")
        expect(recipient.registration_office).to      eq("")
        expect(recipient.occupation).to               eq("")
        expect(recipient.facebook).to                 eq("")
        expect(recipient.revenue).to                  eq("")
        expect(recipient.legal_structure).to          eq("")
        expect(recipient.industry).to                 eq("")
        expect(recipient.place_of_birth).to           eq("")
        expect(recipient.nationality).to              eq("")
        expect(recipient.gender).to                   eq("")
        expect(recipient.country).to                  eq("US")
        expect(recipient.description).to              eq("")
        expect(recipient.address).to                  eq("123 Fake St")
        expect(recipient.city).to                     eq("Boulder")
        expect(recipient.state).to                    eq("CO")
        expect(recipient.postalcode).to               eq("80123")
        expect(recipient.tags).to                     eq("")
        expect(recipient.dob_year).to                 eq(1990)
        expect(recipient.dob_month).to                eq(6)
        expect(recipient.dob_day).to                  eq(12)
        expect(recipient.ofac_at).to                  eq(1481154927)
        expect(recipient.created_at).to               eq(1481154894)
        expect(recipient.updated_at).to               eq(1481154927)
        expect(recipient.accepted_terms).to           eq(true)
        expect(recipient.onboard_step).to             eq("success")
        expect(recipient.onboard).to                  eq("complete")
        expect(recipient.onboard_at).to               eq(1481154904)
        expect(recipient.restricted_international).to eq(false)
      end
    end

  end

  describe "#wallets" do
    before { VCR.insert_cassette("recipient-find") }
    after  { VCR.eject_cassette }

    subject { described_class.find("5848a14e4427b9090041ccde") }

    it "returns a list of wallets" do
      wallet = subject.wallets.first

      expect(wallet.id).to    eq("5848a1e4ae6b830700d8ad88")
      expect(wallet.last4).to eq("4321")
    end
  end
end
