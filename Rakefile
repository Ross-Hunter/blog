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

# Deploys happen in GitHub Actions (.github/workflows/deploy.yml) on every
# push to master. This re-runs that workflow manually.
desc "Build and deploy master to GitHub Pages via GitHub Actions"
task :deploy do
  sh "gh workflow run deploy.yml --ref master"
end
