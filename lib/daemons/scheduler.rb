#!/usr/bin/env ruby
ENV["RAILS_ENV"] ||= "production"
rails_load_path=File.expand_path("../../../config/environment.rb", __FILE__)
require 'daemons'
require 'rufus/scheduler'
Daemons.run_proc('scheduler.rb') do
  require rails_load_path
  scheduler = Rufus::Scheduler.start_new
  logger = Logger.new(File.join(Rails.root,'log','scheduler.log'), 'monthly')
  logger.level = Logger::INFO
  logger.formatter = Logger::Formatter.new
  Rails.logger = logger

  scheduler.every '1m' do
    Rails.logger.info "Processing mail queue..."
    EmailDelivery.cron
  end
  scheduler.join
end
