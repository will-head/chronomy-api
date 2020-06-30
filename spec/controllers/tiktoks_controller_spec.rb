require 'rails_helper'

RSpec.describe TiktoksController, type: :controller do

  it 'unshorten expands short url to long url' do
    expect(subject.unshorten("https://vm.tiktok.com/sj81dJ/")).to eq "https://www.tiktok.com/@jdmoosetracks/video/6806059951526628614"
  end

  it 'unshorten expands short url to long url' do
    expect(subject.unshorten("https://m.tiktok.com/v/6806059951526628614.html")).to eq "https://www.tiktok.com/@jdmoosetracks/video/6806059951526628614"
  end

  it 'unshorten expands short url to long url' do
    expect(subject.unshorten("https://www.tiktok.com/@jdmoosetracks/video/6806059951526628614?u_code=d2ka6dmhljgd8l&preview_pb=0&language=en&timestamp=1584757918&utm_campaign=client_share&app=musically&utm_medium=ios&user_id=6615784316830760965&tt_from=copy&utm_source=copy&source=h5_m")).to eq "https://www.tiktok.com/@jdmoosetracks/video/6806059951526628614"
  end

end
