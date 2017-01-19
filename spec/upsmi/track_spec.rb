require 'spec_helper'

describe "UPSMI::Track" do
  it 'invalid tracking' do 
    expect { Omniship::UPSMI.track(UPSMI_TEST_NUMBER)  }.to_not raise_error(Omniship::TrackError)
    expect { Omniship::UPSMI.track(UPS_INVALID_TEST_NUMBER)  }.to raise_error(Omniship::TrackError)
  end
  
  it 'test xml parsing' do 
    trk = Omniship::UPS::Track::Response.new(Nokogiri::XML::Document.parse(track_ups_response))
    expect(trk.has_left?).to eq true
    expect(trk.has_arrived?).to eq true
    expect(trk.shipment.packages.first.activity.first.address.to_s).to eq("SANTA CLARA, CA 95053 US")
    expect(trk.shipment.packages.first.activity.first.timestamp).to_not be_nil
  end
end

