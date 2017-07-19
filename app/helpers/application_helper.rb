module ApplicationHelper
  def body_class
      controller.controller_path
  end
  def last_sessions_rada
    Division.pluck(:date).last.strftime('%d.%m.%Y')
  end
  def last_update_rada
    Division.pluck(:updated_at).last.strftime('%d.%m.%Y / %H:%M')
  end
end
