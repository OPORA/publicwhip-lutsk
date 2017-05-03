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
end
