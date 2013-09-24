## Overview

This is an example project which will create a [Zencoder](http://zencoder.com) job and register a webhook to listen for notifications on the job state. Gon watch](https://github.com/gazay/gon/wiki/Usage-gon-watch) is then used to push updates to the client with the jobs process state.

## Setting up the project

1. Create a [Zencoder](http://zencoder.com) account
2. rake db:migrate
3. bundle install
4. Add your own .env file with the following:

		ZENCODER_API_KEY: your-zencoder-account-api-key
		NOTIFICATION_AUTH_NAME: your-auth-name
		NOTIFICATION_AUTH_PASSWORD: your-auth-secret
		PROCESSED_WEBHOOK: http://zencoderfetcher/api/zencoder/processed

5. rails s

## Testing Zencoder

1. Install the [zencoder-fetcher](http://goo.gl/i1tKI4) gem
2. Run the following in Terminal: `zencoder_fetcher your-zencoder-account-api-key --count 1 --url http://your-auth-name:your-auth-secret@localhost:3000/api/zencoder/processed`