class Mp < ActiveRecord::Base
  def url_name
    self.last_name + "_" + self.first_name
  end
end
