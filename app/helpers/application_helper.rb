module ApplicationHelper
  def page_title(title = '')
    base_title = 'EngineerBook'
    title.present? ? "#{title} - #{base_title}" :  base_title
  end

  def date(datetime)
    datetime.strftime('%Y年%m月%d日')
  end
end
