module DivisionsHelper
  def sort_division
    if params[:sort] == "subject"
      "Алфавітом"
    elsif params[:sort] == "rebellions"
      "Дотриманням фракційної дисципліни"
    elsif params[:sort] == "attendance"
      "Присутністю"
    else
      "Датою"
    end
  end
  def class_division(result)
    case result
      when "Прийнято"
        "passed"
      else
        "no_passed"
    end
  end
  def result_voted_mp(res)
    case res
      when "not_voted"
        "Не голосував"
      when "absent"
        "Відсутній"
      when "against"
        "Ні"
      when "aye"
        "Так"
      when "abstain"
        "Утримався"
    end
  end
end
