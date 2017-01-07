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

task :default => :server