require 'rails_helper'

RSpec.describe PlaceholderPlaylistsController, type: :controller do

  describe 'GET /placeholder/playlists' do

    it 'returns success' do
      get :home
      expect(response).to be_successful
    end

    it 'returns a hard coded test JSON array' do
      get :home
      expect(JSON.parse(response.body)).to include_json(
        [
          {
            "id": "1",
            "title": "playlist1",
            "uuid": "40c5b468-13af-483d-8728-eb4f85a9f765"
          }
      
        ]
      )
    end

  end
end
