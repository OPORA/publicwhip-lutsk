module PeopleHelper

  def member_role(faction, okrug)
    first ='Член фракції політичної партії "' + faction +'"'
    unless okrug.nil?
      first + " обрано по округу номер #{okrug}"
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
  def result_voted(res)
    case res
      when "not_voted"
        "не голосував"
      when "absent"
        "був відсутній"
      when "against"
        "голосував проти"
      when "aye"
        "голосував за"
      when "abstain"
        "утримався"
    end
  end
end
