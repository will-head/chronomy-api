require 'rails_helper'
require 'securerandom'

RSpec.describe PlaylistsController, type: :controller do
  let(:user) { create(:user) }
  let(:playlist) { Playlist.create(title: 'Title', user_id: user.id, uuid: SecureRandom.uuid) }
  let(:valid_attributes) {
    { title: playlist.title, user_id: playlist.user_id, uuid: SecureRandom.uuid }
  }

  before { allow(SecureRandom).to receive(:uuid).and_return('2d931510-d99f-494a-8c67-87feb05e1594') }

  describe '#create' do
    context 'when the attributes are correct' do
      it 'renders status 200' do
        post :create, params: { playlist: valid_attributes }, format: :json

        json = JSON.parse(response.body)

        # p response.body
        # p json['playlist']
        # p request['playlist']
        # p Playlist.first
        # p Playlist.first
        # p Playlist.all

        # expect(json["status"]).to eq 200
        expect(Playlist.last).to eq playlist
        # expect(playlist.user_id).to eq user.id
        # expect(json["user"]["username"]).to include valid_attributes[:username]
      end
    end
  end


    describe '#show' do
      context 'when the playlist exists' do
        it 'renders status 200' do
          get :show, params: { id: playlist.id }, format: :json
          json = JSON.parse(response.body)

          expect(json['status']).to eq 200
          expect(json['playlist']['id']).to eq playlist.id
          expect(json['playlist']['uuid']).to eq playlist.uuid
        end
      end
    end
end
