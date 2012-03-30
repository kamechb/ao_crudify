# Base methods for CRUD actions
# Simply override any methods in your action controller you want to be customised
# Don't forget to add:
#   resources :plural_model_name_here
# to your routes.rb file.
# Example (add to your controller):
# crudify :foo, { :title_attribute => 'name' }


module AoCrudify
  module ResponseCode
    SUCCESS = 1
    ERROR   = 0
  end

  module Base
    def self.default_options(model_name)
      singular_name = model_name.to_s
      plural_name = singular_name.pluralize
      class_name = singular_name.camelize
      {
        :title_attribute => singular_name,
        :singular_name => singular_name,
        :plural_name => plural_name,
        :class_name => class_name,
        :paginate => true,
        :order_by => :created_at,
        :direction => :numdesc,
        :conditions => {},
        :redirect_to_url => "admin_#{plural_name}_path",
        :log => Rails.env == 'development'
      }
    end

    def self.append_features(base)
      super
      base.send(:include, AoCrudify::HookMethods)
      base.extend(AoCrudify::ClassMethods)
    end

  end

end
