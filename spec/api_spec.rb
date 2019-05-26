# frozen_string_literal: true

RSpec.describe URLhaus::API, :vcr do
  subject { described_class.new }

  describe "#url" do
    let(:url) { "http://sskymedia.com/VMYB-ht_JAQo-gi/INV/99401FORPO/20673114777/US/Outstanding-Invoices/" }

    it do
      res = subject.url(url)
      expect(res.dig("url")).to eq(url)
    end
  end

  describe "#host" do
    let(:host) { "vektorex.com" }

    it do
      res = subject.host(host)
      expect(res.dig("host")).to eq(host)
    end
  end

  describe "#payload" do
    let(:md5_hash) { "12c8aec5766ac3e6f26f2505e2f4a8f2" }
    let(:sha256_hash) { "01fa56184fcaa42b6ee1882787a34098c79898c182814774fd81dc18a6af0b00" }

    it do
      res = subject.payload(md5_hash)
      expect(res.dig("md5_hash")).to eq(md5_hash)
    end

    it do
      res = subject.payload(sha256_hash)
      expect(res.dig("sha256_hash")).to eq(sha256_hash)
    end
  end

  describe "#tag" do
    let(:tag) { "Retefe" }

    it do
      res = subject.tag(tag)
      expect(res.dig("query_status")).to eq("ok")
    end
  end

  describe "#signature" do
    let(:signature) { "Gozi" }

    it do
      res = subject.signature(signature)
      expect(res.dig("query_status")).to eq("ok")
    end
  end
end
