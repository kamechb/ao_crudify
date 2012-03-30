class Jelly < ActiveObject::Base
  establish_connection(:tokyo_cabinet_table, :path => File.expand_path("../../../db/Jelly.tct", __FILE__))
  attribute :title => :string,
            :name => :string

  validates_presence_of :title
  validates_presence_of :name

  def self.per_page
    3
  end

end
