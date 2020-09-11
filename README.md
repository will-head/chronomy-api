# chronomy-api

[![Build Status](https://travis-ci.com/will-head/chronomy-api.svg?branch=master)](https://travis-ci.com/will-head/chronomy-api)

## Overview

Chronomy lets users curate [TikTok](https://www.tiktok.com/) playlists.

There is a lot of original, unique content on the platform but not all of it is suitable for a young audience.

Chronomy lets curators create playlists of suitable content and then share them with specific people.

Playlists are shared with deliberately long UUID based URLs to ensure they are effectively private and can't be discovered unintentionally.

This is the api backend for app, the frontend is here:
[github.com/will-head/chronomy-web](https://github.com/will-head/chronomy-web)

![Chronomy Player on a phone](./images/chronomy-04.jpg "Chronomy Player on a phone")

## Setup

```bash
$ bundle install
$ rails db:create
$ rails db:migrate
$ rails s -p 3001
```

## Testing

To run RSpec (with coverage) followed by Rubocop run script:  

```bash
$ ./test/tdd.test
```

## Approach

The backend uses Rails and outputs JSON. It's set to automatically deploy to [https://chronomy.herokuapp.com](https://chronomy.herokuapp.com/) when continuous integration tests on [Travis](https://travis-ci.com/) pass.

## Database Models

The data is held in four tables:

### User table

Username, email and password so curators so they can login to the site

| id  | username | email              | password |
|:--- |:-------- | ------------------ | -------- |
| 1   | user_1   | user_1@example.com | password |
| 2   | user_2   | user_2@example.com | password |

### Playlists table

Playlist title, uuid (for share link) and who it belongs to

| id  | title            | uuid                                 | user_id |
|:--- |:---------------- | ------------------------------------ | ------- |
| 1   | Dance Challenges | 18dc1213-07f2-4b43-9c4f-c254d71796bf | 1       |
| 2   | Duets            | cf3a21d1-e8b3-4e2f-b2d8-f978edcb81a0 | 2       |

### TikToks table

The original url, mp4 url and title text

| id  | original_url                                                                                                  | mp4_url                                                                                         | title                                                                             |
|:--- |:------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| 1   | [https://www.tiktok.com/@mine.../67322...](https://www.tiktok.com/@minecrafter2011/video/6732210815300111622) | [https://v.tiktok.fail/af5be...mp4](https://v.tiktok.fail/af5bec5b0a331cecc9c49337287bb20c.mp4) | Spooky season dance, try it, it’s so fun #fyp #duetthis #dance #halloween #foryou |
| 2   | [https://www.tiktok.com/@hann.../68092...](https://www.tiktok.com/@hannahsimpsonx/video/6809258299985267974)  | [https://v.tiktok.fail/401fa...mp4](https://v.tiktok.fail/401fa7a6eedaf512427da188e89f37eb.mp4) | #blindinglightschallenge                                                          |

### Playlist TikToks table

Which TikToks are in which Playlists

| id  | tiktok_id | playlist_id |
|:--- |:--------- | ----------- |
| 1   | 1         | 1           |
| 2   | 1         | 2           |
| 3   | 2         | 1           |
| 4   | 2         | 2           |

## Code Structure

Curators can sign up and login using the `registrations` and `sessions` controllers.

The `tiktoks` controller ensures TikToks are unique before being added to the database (even if different source URLs for the same TikTok are used) and queries the official TikTok api to get the title. The link for the MP4 file is provided by a 3rd party API.

The `playlists` controller handles adding or deleting TikToks from playlists and generating the shareable UUID link for each playlist.

## API

The api is accessible at:  
https://chronomy.herokuapp.com/

### Feeds

#### POST `/registrations`

Expects a username, email and password and returns a valid user on success, or 401 on failure

```bash
curl --request POST \
  --url https://chronomy.herokuapp.com/registrations \
  --header 'content-type: application/json' \
  --data '{"user": {"username": "username", "email": "email@example.com", "password": "password"}}'
```

Success

```json
{
  "status": 200,
  "user": {
    "id": 1,
    "username": "username",
    "email": "email@example.com",
    "password_digest": "$2a$12$jcocczPTpxpyatUeehLC8u5oNyvclH6IewKhXRHk.yz1SllF2ROSa",
    "created_at": "2020-06-29T15:15:31.533Z",
    "updated_at": "2020-06-29T15:15:31.533Z"
  }
}
```

#### POST `/sessions`

Expects a username and password and stores the user id in an encrypted cookie on success, returning a valid user or 401 on failure

```bash
curl --request POST \
  --url https://chronomy.herokuapp.com/sessions \
  --header 'content-type: application/json' \
  --data '{"user": {"username": "username", "password": "password"}}'
```

Success

```json
{
  "status": 200,
  "logged_in": true,
  "user": {
    "id": 1,
    "username": "username",
    "email": "email@example.com",
    "password_digest": "$2a$12$jcocczPTpxpyatUeehLC8u5oNyvclH6IewKhXRHk.yz1SllF2ROSa",
    "created_at": "2020-06-29T15:15:31.533Z",
    "updated_at": "2020-06-29T15:15:31.533Z"
  }
}
```

#### GET `/logged_in`

Returns whether a user is logged in or not.

```bash
curl --request GET \
  --url https://chronomy.herokuapp.com/logout
```

Success

```json
{
  "logged_in": true,
  "user": {
    "id": 1,
    "username": "username",
    "email": "email@example.com",
    "password_digest": "$2a$12$jcocczPTpxpyatUeehLC8u5oNyvclH6IewKhXRHk.yz1SllF2ROSa",
    "created_at": "2020-06-29T15:15:31.533Z",
    "updated_at": "2020-06-29T15:15:31.533Z"
  }
}
```

#### DEL `/logout`

Deletes the session and logs the user out

```bash
curl --request DELETE \
  --url https://chronomy.herokuapp.com/logout
```

Success

```json
{
  "status": 200,
  "logged_in": false
}
```

#### POST `/playlists`

Create a playlist, given a title and list of TikTok URLs (requires authorised user)

```bash
curl --request POST \
  --url https://chronomy.herokuapp.com/playlists \
  --header 'content-type: application/json' \
  --data '{
	"playlist": {
		"title": "Playlist",
		"tiktoks": [
			"https://www.tiktok.com/@minecrafter2011/video/6732210815300111622",
			"https://vm.tiktok.com/JercUtG/"
		]
	}
}'
```

Success

```json
{
  "status": 200,
  "playlist": {
    "id": 43,
    "title": "Playlist",
    "uuid": "44f7d6bc-8ab0-41bd-8186-ef62809f4329",
    "user_id": 1,
    "created_at": "2020-09-11T13:45:54.794Z",
    "updated_at": "2020-09-11T13:45:54.794Z"
  }
}
```

#### PUT `/playlists/{UUID}`

Update a playlist, given a title and list of TikTok URLs (requires authorised user)

```bash
curl --request PUT \
  --url https://chronomy.herokuapp.com/playlists/44f7d6bc-8ab0-41bd-8186-ef62809f4329 \
  --header 'content-type: application/json' \
  --data '{
	"playlist": {
		"title": "Playlist",
		"tiktoks": [
			"https://www.tiktok.com/@jeremylynchofficial/video/6823406365621423365",
			"https://vm.tiktok.com/JercUtG/"
		]
	}
}'
```

Success

```json
{
  "status": 200,
  "playlist": {
    "user_id": 1,
    "id": 43,
    "title": "Playlist",
    "uuid": "44f7d6bc-8ab0-41bd-8186-ef62809f4329",
    "created_at": "2020-09-11T13:45:54.794Z",
    "updated_at": "2020-09-11T13:45:54.794Z"
  }
}
```

#### DEL `/playlists/{UUID}`

Delete a playlist (requires authorised user)

```bash
curl --request DELETE \
  --url https://chronomy.herokuapp.com/playlists/1aa1e78f-370b-4dce-bb86-47236f418066 \
  --header 'content-type: application/json'
```

Success

```json
{
  "status": 200,
  "deleted": true
}
```

#### GET `/playlists_by_user`  

Find all playlists belonging to the user (requires authorised user)

```bash
curl --request GET \
  --url https://chronomy.herokuapp.com/playlists_by_user
```

```json
{
  "status": 200,
  "playlists_by_user": [
    {
      "id": 26,
      "title": "Dance Challenges",
      "uuid": "cf3a21d1-e8b3-4e2f-b2d8-f978edcb81a0",
      "user_id": 1,
      "created_at": "2020-07-02T13:43:28.289Z",
      "updated_at": "2020-07-02T13:43:28.289Z"
    },
    {
      "id": 43,
      "title": "Playlist",
      "uuid": "44f7d6bc-8ab0-41bd-8186-ef62809f4329",
      "user_id": 1,
      "created_at": "2020-09-11T13:45:54.794Z",
      "updated_at": "2020-09-11T13:45:54.794Z"
    }
  ]
}
```

#### GET `/playlists/{UUID}`

Returns the title and mp4 url for all TikToks in the playlist

```bash
curl --request GET \
  --url https://chronomy.herokuapp.com/playlists/44f7d6bc-8ab0-41bd-8186-ef62809f4329
```

Success

```json
{
  "status": 200,
  "playlist": {
    "id": 43,
    "title": "Playlist",
    "uuid": "44f7d6bc-8ab0-41bd-8186-ef62809f4329",
    "user_id": 1,
    "created_at": "2020-09-11T13:45:54.794Z",
    "updated_at": "2020-09-11T13:45:54.794Z"
  },
  "tiktoks": [
    {
      "title": "Spooky season dance, try it, it’s so fun #fyp #duetthis #dance #halloween #foryou",
      "mp4_url": "https://v.tiktok.fail/af5bec5b0a331cecc9c49337287bb20c.mp4",
      "original_url": "https://www.tiktok.com/@minecrafter2011/video/6732210815300111622"
    },
    {
      "title": "#blindinglightschallenge",
      "mp4_url": "https://v.tiktok.fail/401fa7a6eedaf512427da188e89f37eb.mp4",
      "original_url": "https://www.tiktok.com/@hannahsimpsonx/video/6809258299985267974"
    }
  ]
}
```

## Improvements

* Store all data provided by the TikTok api, not just the title
* Check if a TikTok already exists in TikToks table before adding it (not currently working)
