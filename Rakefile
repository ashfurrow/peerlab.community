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

namespace :yaml do
  desc "Check data/events.yml for lexicographical sort by city name"
  task :check do
    contents = File.read("data/events.yml")
    cities = contents.scan(/- city: ([^\n]+)$/).flatten
    unless cities.sort == cities
      fail "data/events.yml is not sorted"
    end
  end

  desc "Sorts data/events.yml lexicographically by city name"
  task :sort do
    # We're going to assume each entry starts with `- city`, as shown in the README
    contents = File.read("data/events.yml")
    entries = contents.split("- city: ").drop(1)
    new_entries = entries
      .map { |e| { name: e.split("\n").first, entry: e }  }
      .sort { |l, r| l[:name] <=> r[:name] }
    new_contents = <<~EOS
      peer_labs:
        #{ new_entries.map { |e| "- city: #{ e[:entry] }" }.join("") }
    EOS
    File.write('data/events.yml', new_contents)
  end
end

task :serve => :server
task :default => :server
