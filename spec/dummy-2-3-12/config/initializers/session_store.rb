# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dummy-2-3-12_session',
  :secret      => 'f56ec4dad6e18153b279e11d400ee9b296565b7a0b55cc5f85ad3469ca9c1751f6c137c1fb39e13ce308199842a159cb1166310190c269e8e7940e929b1cae27'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
