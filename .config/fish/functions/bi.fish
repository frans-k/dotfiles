function bi
  if not type bundle > /dev/null
    gem install bundler
  end
  bundle install $argv
end
