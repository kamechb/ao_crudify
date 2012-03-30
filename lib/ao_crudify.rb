require 'active_support'
require 'action_controller'

module AoCrudify

  if Rails.version > '3'
    class Engine < Rails::Engine
    end
  end

  autoload :HookMethods, 'ao_crudify/hook_methods'
  autoload :ClassMethods, 'ao_crudify/class_methods'
  autoload :Base, 'ao_crudify/base'

end

I18n.load_path << File.expand_path('../../config/locales/en.yml', __FILE__)
I18n.load_path << File.expand_path('../../config/locales/zh-cn.yml', __FILE__)

ActionController::Base.send(:include, AoCrudify::Base)
