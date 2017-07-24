class AddColumnDateToMpIfo < ActiveRecord::Migration[5.1]
  def change
    add_column :mp_infos, :date_mp_info, :date
  end
end
