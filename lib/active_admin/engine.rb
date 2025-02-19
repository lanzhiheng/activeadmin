# frozen_string_literal: true
module ActiveAdmin
  class Engine < ::Rails::Engine
    initializer "active_admin.load_app_path" do |app|
      ActiveAdmin::Application.setting :app_path, app.root
      ActiveAdmin::Application.setting :load_paths, [File.expand_path("app/admin", app.root)]
    end

    initializer "active_admin.precompile", group: :all do |app|
      unless ActiveAdmin.application.use_webpacker
        ActiveAdmin.application.stylesheets.each do |path, _|
          app.config.assets.precompile << path
        end
        ActiveAdmin.application.javascripts.each do |path, _|
          app.config.assets.precompile << path
        end
      end
    end

    initializer "active_admin.routes" do
      require "active_admin/helpers/routes/url_helpers"
    end
  end
end
