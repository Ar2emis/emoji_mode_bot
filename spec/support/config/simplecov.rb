# frozen_string_literal: true

require 'simplecov'

SimpleCov.start 'rails' do
  enable_coverage :branch
  primary_coverage :branch
  minimum_coverage 95
  add_filter '/app/admin'

  groups.clear

  {
    'Models' => 'model',
    'Interactors' => 'interactor',
    'Organizers' => 'organizer',
    'Jobs' => 'job',
    'Concerns' => 'concern',
    'Lib' => 'lib'
  }.each { |name, pattern| add_group(name) { |file| file.filename.include?(pattern) } }

  {
    'Decorators' => 'decorator.rb',
    'Policies' => 'policy.rb',
    'Controllers' => 'controller.rb',
    'Routers' => 'router.rb'
  }.each { |name, pattern| add_group(name) { |file| file.filename.end_with?(pattern) } }
end
