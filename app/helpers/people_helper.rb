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
  def sort_text
     if params[:sort] == "faction"
        "Фракцією"
     elsif params[:sort] == "distric"
        "Округом"
     elsif params[:sort] == "rebellions"
        "Дотриманням фракційної дисципліни"
     elsif params[:sort] == "attendance"
        "Присутністю"
     else
        "Ім'ям"
     end
  end
  def fraction_to_percentage_display(fraction, options = {precision: 2, significant: true})
    if fraction
      percentage = fraction * 100
      number_to_percentage(percentage, options)
    else
      'n/a'
    end
  end
end
