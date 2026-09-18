# Book Collection

## Google sign-in

Book pages require a Google-authenticated session. The app uses Devise and
OmniAuth, starts sign-in with a CSRF-protected POST, and signs out with DELETE.
Google's subject ID identifies an account; the app does not store Google tokens
or passwords. In this course demo, authenticated users share the book collection.

Configure these environment variables using Heroku Config Vars (never commit
their values):

- `GOOGLE_OAUTH_CLIENT_ID`
- `GOOGLE_OAUTH_CLIENT_SECRET`

The Google web client must allow this redirect URI for the existing test app:

`https://test-app-test-pahpkm5oijtqa6x6.herokuapp.com/admins/auth/google_oauth2/callback`

For local development, also register:

`http://localhost:3000/admins/auth/google_oauth2/callback`

Keep the Google app in testing mode and add the Google accounts used for lab
verification as test users. Run `bundle install` and `bundle exec rails db:migrate`
before starting the app. Heroku's release phase runs migrations automatically.

Run `bundle exec rspec` for book behavior, access protection, successful callback,
denied consent, invalid identity, and logout coverage. OAuth is mocked only in
automated tests; submission screenshots must come from a real Google login.

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
