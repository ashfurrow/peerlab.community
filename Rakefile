require 'middleman-gh-pages'
require 'rake'

desc "Deploy if Travis environment variables are set correctly."
task :travis do
  branch = ENV['TRAVIS_BRANCH']
  pull_request = ENV['TRAVIS_PULL_REQUEST']

  abort 'Must be run on Travis' unless branch

  if pull_request != 'false'
    puts 'Skipping deploy for pull request; can only be deployed from master branch.'
    exit 0
  end

  if branch != 'master'
    puts "Skipping deploy for #{ branch }; can only be deployed from master branch."
    exit 0
  end

  Rake::Task['publish'].invoke

  puts 'Invalidating CDN.'
  sleep 20 # Give GitHub time to deploy the site before invalidating.
  CLOUDFLARE_ZONE_ID = '78aee06030dd52496fcc5b508ca32336'
  # Documented at https://api.cloudflare.com/#zone-purge-all-files
  sh <<-EOS
    curl -X DELETE "https://api.cloudflare.com/client/v4/zones/#{CLOUDFLARE_ZONE_ID}/purge_cache" \
    -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
    -H "X-Auth-Key: $CLOUDFLARE_CLIENT_API_KEY" \
    -H "Content-Type: application/json" \
    --data '{"purge_everything":true}'
  EOS
  puts 'Invalidation complete.'
end

desc "Builds the site in the ./test directory."
task :test do
  sh "bundle exec middleman build --build-dir=test"
end

desc "Start middleman server"
task :server do
  puts "Starting Middleman server"
  middleman = Process.spawn("bundle exec middleman")
  trap("INT") {
    Process.kill(9, middleman) rescue Errno::ESRCH
    exit 0
  }
  Process.wait(middleman)
end

desc "Check data/events.yml for lexicographical sort by city name"
task :check_yaml do
  contents = File.read("data/events.yml")
  cities = contents.scan(/- city: ([^\n]+)$/).flatten
  unless cities.sort == cities
    fail "data/events.yml is not sorted"
  end
end

task :serve => :server
task :default => :server
