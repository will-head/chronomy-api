# chronomy-api

## Overview

Chronomy lets users curate [TikTok](https://www.tiktok.com/) playlists.

There is a lot of original, unique content on the platform but not all of it is suitable for a young audience.

Chronomy lets curators create playlists of suitable content and then share them with specific people.

Playlists are shared with deliberately long UUID based URLs to ensure they are effectively private and can't be discovered unintentionally.

This is the api backend for app, the frontend is here:
[github.com/will-head/chronomy-web](https://github.com/will-head/chronomy-web)

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

## Code Structure

Curators can sign up and login using the registrations and sessions controllers.

The tiktoks controller ensures TikToks are unique before being added to the database (even if different source URLs for the same TikTok are used) and queries the official TikTok api to get the title. The link for the MP4 file is provided by a 3rd party API.

The playlists controller handles adding or deleting TikToks from playlists and generating the shareable UUID link for each playlist.

## Improvements

* Store all data provided by the TikTok api, not just the title
