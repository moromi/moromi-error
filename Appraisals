appraise 'rails5.2' do
  gem 'rails', '~> 5.2'
end

appraise 'rails6.0' do
  gem 'rails', '~> 6.0'

  # You don't have net-smtp installed in your application. Please add it to your Gemfile and run bundle install
  gem 'net-smtp'
  gem 'net-imap'
  gem 'net-pop'
end

appraise 'rails6.1' do
  gem 'rails', '~> 6.1'

  # You don't have net-smtp installed in your application. Please add it to your Gemfile and run bundle install
  gem 'net-smtp'
  gem 'net-imap'
  gem 'net-pop'
end

if RUBY_VERSION >= '2.7.0'
  appraise 'rails7.0' do
    gem 'rails', '~> 7.0'
  end
end
