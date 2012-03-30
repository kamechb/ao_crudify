require File.expand_path('../../spec_helper', __FILE__)


describe AoCrudify do

  before do

    Jelly.connection.clear
    10.times{|i|
      Jelly.create(:title => "Yummy Jelly #{i}", :name => "Sample #{i}")
    }

    @controller = JelliesController.new
    @controller.params = {}
    @controller.stub!(:paginate_options).and_return(
      :page => 1,
      :per_page => 3,
      :order_by => :created_at,
      :direction => :numdesc
    )
    @controller.stub!(:conditions).and_return({})
  end

  it "should have crud methods" do
    [
      :find_jelly,
      :find_all_jellies,
      :paginate_all_jellies,
    ].each do |method|
      @controller.methods.should include(method.to_s)
    end
  end

  it "should have private hook methods" do
    [
      :before_create,
      :before_update,
      :successful_create,
      :successful_update,
      :successful_destroy,
      :after_success,
      :failed_create,
      :failed_update,
      :failed_destroy,
      :after_fail
    ].each do |method|
      @controller.private_methods.should include(method.to_s)
    end
  end

  it "should get collection" do
    jellies = @controller.send(:find_all_jellies)
    jellies.should have(10).items
  end

  it "should paginate collection" do
    jellies = @controller.send(:paginate_all_jellies)

    jellies.should have(3).items
  end

end
