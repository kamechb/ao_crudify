#
# Disclaimer:
#
# The majority of this was originally written by
# the splendid fellows at Resolve Digital for their
# awesome refinerycms project.
#

module AoCrudify

  module ClassMethods

    def crudify(model_name, options = {})

      options = ::AoCrudify::Base.default_options(model_name).merge(options)

      singular_name = options[:singular_name]
      plural_name   = options[:plural_name]
      class_name    = options[:class_name]
      klass         = class_name.constantize

      options[:paginate] = options[:paginate] && klass.respond_to?(:paginate)

      module_eval %(

        # (Just a comment!)

        before_filter :find_#{singular_name},
                      :only => [:update, :destroy, :edit, :show]

        before_filter :set_crud_options

        def set_crud_options
          @crud_options ||= #{options.inspect}
        end

        def what
          @what ||= '#{options[:title_attribute]}'
        end

        def index
        end

        def show
        end

        def new
          @#{singular_name} = #{class_name}.new
        end


        def create
          @instance = @#{singular_name} = #{class_name}.new(params[:#{singular_name}])
          return if before_create === false
          if @instance.save
            successful_create
          else
            failed_create
          end
        end

        def edit

        end

        def update
          return if before_update === false
          if @#{singular_name}.update_attributes(params[:#{singular_name}])
            successful_update
          else
            failed_update
          end
        end

        def destroy
          return if before_destroy === false
          if @#{singular_name}.destroy
            successful_destroy
          else
            failed_destroy
          end
        end

        # Finds one single result based on the id params.
        def find_#{singular_name}
          set_instance(#{class_name}.find(params[:id]))
        end

        def paginate_all_#{plural_name}
          set_collection(#{class_name}.paginate paginate_options.merge(conditions))
        end

        def find_all_#{plural_name}
          set_collection(#{class_name}.all conditions)
        end

        def paginate_options
          @paginate_options ||= {
            :page => params[:page],
            :per_page => params[:per_page],
            :order_by => :#{options[:order_by]},
            :direction => :#{options[:direction]}
          }
        end

        def conditions
          @conditions ||= @crud_options[:conditions]
        end

        def set_instance(record)
          @instance = @#{singular_name} = record
        end

        def set_collection(records)
          @collection = @#{plural_name} = records
        end

      )


      if options[:paginate]
        module_eval %(
          def index
            paginate_all_#{plural_name}
          end
        )
      else
        module_eval %(
          def index
            find_all_#{plural_name}
          end
        )
      end
    end

  end
end
