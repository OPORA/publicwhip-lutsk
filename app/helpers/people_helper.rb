module PeopleHelper
  def full_name(first_name, middle_name, last_name)
    last_name + " " + first_name + " " + middle_name
  end

  def member_role(faction, okrug)
    first ='Член фракції політичної партії "' + faction +'"'
    unless okrug.nil?
      first + " обрано по окрогу номер #{okrug}"
    else
      first
    end
  end
end
