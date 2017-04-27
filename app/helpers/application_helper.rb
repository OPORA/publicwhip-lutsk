module ApplicationHelper
  def body_class
      controller.controller_path
  end
end
