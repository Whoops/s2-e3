require 'rake'
require 'spec/rake/spectask'

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.spec_opts = ['--format','p','--color']
end

desc "Run the game!"
task :run do
  ruby ' -I lib/ bin/game.rb config/adventure.yml'
end