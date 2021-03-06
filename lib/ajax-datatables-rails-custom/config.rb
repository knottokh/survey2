# frozen_string_literal: true

require 'active_support/configurable'

module AjaxDatatablesRailsCustom

  # configure AjaxDatatablesRails global settings
  #   AjaxDatatablesRails.configure do |config|
  #     config.db_adapter = :postgresql
  #   end
  def self.configure
    yield @config ||= AjaxDatatablesRailsCustom::Configuration.new
  end

  # AjaxDatatablesRails global settings
  def self.config
    @config ||= AjaxDatatablesRailsCustom::Configuration.new
  end

  def self.old_rails?
    Rails::VERSION::MAJOR == 4 && (Rails::VERSION::MINOR == 1 || Rails::VERSION::MINOR == 0)
  end

  class Configuration
    include ActiveSupport::Configurable

    config_accessor(:orm) { :active_record }
    config_accessor(:db_adapter) { :postgresql }
  end
end
