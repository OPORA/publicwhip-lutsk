
class MonthUkr
  attr_accessor :month

  def self.month_to_i(month)
    case  month
      when "січня"
        1
      when "лютого"
        2
      when "березня"
        3
      when "квітня"
        4
      when "травня"
        5
      when "червня"
        6
      when "липня"
        7
      when "серпня"
        8
      when "вересня"
        9
      when "жовтня"
        10
      when "листопада"
        11
      when "грудня"
        12
      else
        raise "Unknown month #{month}"
    end
  end
  def self.i_to_month(month)
    case month.to_i
      when 1
        "січнь"
      when 2
        "лютий"
      when 3
        "березнь"
      when 4
        "квітень"
      when 5
        "травень"
      when 6
        "червнь"
      when 7
        "липень"
      when 8
        "серпень"
      when 9
        "вересень"
      when 10
        "жовтень"
      when 11
        "листопад"
      when 12
        "грудень"
      else
        raise "Unknown month #{month}"
    end
  end
end