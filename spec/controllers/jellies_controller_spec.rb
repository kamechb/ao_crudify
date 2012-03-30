require File.expand_path('../../spec_helper', __FILE__)

def should_assign_instance
  assigns[:jelly].should_not be_nil
  assigns[:crud_options].should_not be_nil
end

describe JelliesController do
  describe "get new" do
    it "should assign @jelly, @crud_options" do
      get :new
      should_assign_instance
    end
  end

  describe "get index" do
    it "should call paginate_all_* methods and assign @jellies and @collection" do
      get :index
      assigns[:jellies].should_not be_nil
      assigns[:collection].should_not be_nil
    end
  end

  describe "get show" do
    before do
      Jelly.stub(:find).and_return mock_model(Jelly)
    end
    it "should assign instance" do
      get :show
      should_assign_instance
    end
  end

  describe "post create" do
    before do
      @jelly = mock_model(Jelly)
      Jelly.stub(:new).and_return @jelly
    end
    it "with before_create return false" do
      controller.stub!(:before_create).and_return false
      @jelly.should_not_receive(:save)
      post :create, :name => 'foo', :title => 'bar'
      controller.stub!(:before_create).and_return true
    end
    context "create success" do
      before do
        @jelly.stub(:save).and_return true
      end
      it "with http redirect param" do
        post :create, :name => 'foo', :title => 'bar', :redirect => "/jellies"
        response.should redirect_to("/jellies")
      end
      it "with @redirect_to_url instance" do
        controller.instance_variable_set("@redirect_to_url", '/jellies/tmp')
        post :create, :name => 'foo', :title => 'bar'
        response.should redirect_to("/jellies/tmp")
        controller.instance_variable_set("@redirect_to_url", nil)
      end
      it "with @crud_options[:redirect_to_url]" do
        post :create, :name => 'foo', :title => 'bar'
        response.should redirect_to("/jellies_url")
      end
      it "with xhr for html format" do
        xhr :post, :create, :name => 'foo', :title => 'bar'
        response.should render_template("create")
      end
      it "post for json format" do
        post :create, :name => 'foo', :title => 'bar', :format => 'json'
        response.body.should include('code')
      end
    end
    context "create failed" do
      before do
        @jelly.stub(:save).and_return false
      end
      it "with http" do
        post :create, :name => 'foo', :title => 'bar'
        response.should render_template("new")
      end
      it "with ajax" do
        xhr :post, :create, :name => 'foo', :title => 'bar'
        response.body.should == 'error'
      end
    end
  end

  describe "put update" do
    before do
      @jelly = mock_model(Jelly)
      Jelly.stub(:find).and_return @jelly
    end
    it "with before_update return false" do
      controller.stub!(:before_update).and_return false
      @jelly.should_not_receive(:update_attributes)
      put :update, :id => @jelly.id, :jelly => {:name => 'update name', :title => 'update title'}
      controller.stub!(:before_update).and_return true
    end
    context "update successful" do
      before do
        @jelly.stub!(:update_attributes).and_return true
      end
      it "with http redirect param" do
        put :update, :id => @jelly.id, :jelly => {:name => 'foo', :title => 'bar'}, :redirect => "/jellies"
        response.should redirect_to("/jellies")
      end
      it "with @redirect_to_url instance" do
        controller.instance_variable_set("@redirect_to_url", '/jellies/tmp')
        put :update, :id => @jelly.id, :jelly => {:name => 'foo', :title => 'bar'}
        response.should redirect_to("/jellies/tmp")
        controller.instance_variable_set("@redirect_to_url", nil)
      end
      it "with @crud_options[:redirect_to_url]" do
        put :update, :id => @jelly.id, :jelly => {:name => 'foo', :title => 'bar'}
        response.should redirect_to("/jellies_url")
      end
      it "with xhr for html format" do
        xhr :put, :update, :id => @jelly.id, :jelly => {:name => 'foo', :title => 'bar'}
        response.should render_template("update")
      end
      it "put for json format" do
        put :update, :id => @jelly.id, :jelly => {:name => 'foo', :title => 'bar'}, :format => 'json'
        response.body.should include('code')
      end
    end
    context "update failed" do
      before do
        @jelly.stub(:update_attributes).and_return false
      end
      it "with http" do
        put :update, :id => @jelly.id, :jelly => {:name => 'foo', :title => 'bar'}
        response.should render_template("edit")
      end
      it "with ajax" do
        xhr :put, :update, :id => @jelly.id, :jelly => {:name => 'foo', :title => 'bar'}
        response.body.should == 'error'
      end
      it "flash[:error] should exist" do
        xhr :put, :update, :id => @jelly.id, :jelly => {:name => 'foo', :title => 'bar'}
        flash[:error].should == I18n.t("ao_crudify.failed_update", :what => 'jelly')
      end
    end
  end

  describe "delete destroy" do
    before do
      @jelly = mock_model(Jelly)
      Jelly.stub(:find).and_return @jelly
    end
    it "with before_destory return false" do
      controller.stub!(:before_destroy).and_return false
      @jelly.should_not_receive :destroy
      delete :destroy, :id => @jelly.id
      controller.stub!(:before_destroy).and_return true
    end
  end
end
