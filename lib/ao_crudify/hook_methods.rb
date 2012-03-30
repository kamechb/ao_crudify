module AoCrudify

  module HookMethods

    private

      def before_create
        # just a hook!
        puts "> Crud::before_create" if @crud_options[:log]
        before_action
      end

      def before_update
        # just a hook!
        puts "> Crud::before_update" if @crud_options[:log]
        before_action
      end

      def before_destroy
        # just a hook!
        puts "> Crud::before_destroy" if @crud_options[:log]
        before_action
      end

      def before_action
        # just a hook!
        puts "> Crud::before_action" if @crud_options[:log]
        true
      end


      def successful_create
        puts "> Crud::successful_create" if @crud_options[:log]

        flash[:notice] = t('ao_crudify.created', :what => what)

        after_success
      end

      def successful_update
        puts "> Crud::successful_update" if @crud_options[:log]

        flash[:notice] = t('ao_crudify.updated', :what => what)

        after_success
      end

      def successful_destroy
        puts "> Crud::successful_destroy" if @crud_options[:log]
        flash[:notice] = t('ao_crudify.destroyed', :what => what)

        after_success
      end

      def after_success
        puts "> Crud::after_success" if @crud_options[:log]
        respond_to do |f|
          f.html {
            if request.xhr?
              render @ajax_render_options and return if @ajax_render_options
              render :layout => false
            else
              redirect_to params[:redirect] and return if params[:redirect] && whitelist_redirect(params[:redirect])
              redirect_to @redirect_to_url and return if @redirect_to_url
              redirect_to @crud_options[:redirect_to_url] and return if @crud_options[:redirect_to_url]
              render
            end
          }
          f.json { render :json => {:code => ResponseCode::SUCCESS} }
        end
      end




      def failed_create
        puts "> Crud::failed_create" if @crud_options[:log]
        flash[:error] = t('ao_crudify.failed_create', :what => what)
        after_fail
      end

      def failed_update
        puts "> Crud::failed_update" if @crud_options[:log]
        flash[:error] = t('ao_crudify.failed_update', :what => what)
        after_fail
      end

      def failed_destroy
        puts "> Crud::failed_destroy" if @crud_options[:log]
        flash[:error] = t('ao_crudify.failed_destroy', :what => what)
        after_fail
      end

      def after_fail
        puts "> Crud::after_fail" if @crud_options[:log]
        respond_to do |f|
          f.html {
            if request.xhr?
              render :text => 'error'
            else
              render :text => 'error' and return if request.delete?
              render :action => :new and return if request.post?
              render :action => :edit
            end
          }
          f.json { render :json => {:code => ResponseCode::ERROR} }
        end
      end

      # 对redirect url进行白名单过滤，防止跳转到attack的网站, default true.
      def whitelist_redirect(url)
        true
      end

    end

end
