require 'month_ukr'
module SumisneHolosuvanniaHelper
  def month(month)
    date = month.split('-')
    MonthUkr.i_to_month(date[1]) + " " + date[0]
  end
end
