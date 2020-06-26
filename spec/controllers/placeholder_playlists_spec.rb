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
          },
          {
            "id": "2",
            "title": "playlist2",
            "uuid": "ddfd3bcc-bc63-4d78-88e6-8bcc17c0bd41"
          },
          {
            "id": "3",
            "title": "playlist3",
            "uuid": "0ccba4e9-1a7f-43f0-8672-ce8c7eaa7361"
          }
        ]
      )
    end

  end
end
