require 'rubygems'
# require 'dotenv/tasks'
# require 'httparty'
# require 'dotenv'

# Dotenv.load

task default: %w[server]

desc "Completely empty /build"
task :clean do
  sh "rm -rf build/* build/.[Dh]*"
end
task c: :clean

task :server do
  sh "bundle exec middleman server"
end
task s: :server

task :build do
  sh "bundle exec middleman build"
end
task b: :build

task :deploy do
  sh "bundle exec mgd"
end
