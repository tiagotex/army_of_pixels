require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ArmyOfPixels
  class Application < Rails::Application
     config.autoload_paths += [
      config.root.join('lib')
    ]

    Warden::Manager.serialize_into_session do |user|
      user.id
    end

    Warden::Manager.serialize_from_session do |id|
      User.find_by_id(id)
    end

    class UnauthorizedController < ActionController::Metal
      include ActionController::UrlFor
      include ActionController::Redirecting
      include Rails.application.routes.url_helpers
      include Rails.application.routes.mounted_helpers

      delegate :flash, :to => :request

      def self.call(env)
        @respond ||= action(:respond)
        @respond.call(env)
      end

      def respond
        unless request.get?
          message = env['warden.options'].fetch(:message, "unauthorized.user")
          flash.alert = I18n.t(message)
        end

        redirect_to new_session_url
      end
    end

    require 'pixels_camp_auth_strategy'
    config.middleware.insert_after ActionDispatch::Flash, Warden::Manager do |manager|
      manager.default_strategies :pixels_camp_auth
      manager.failure_app = UnauthorizedController
    end
  end
end
