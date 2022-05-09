module ApplicationHelper
  def page_title(title = '')
    base_title = 'EngineerBook'
    title.present? ? "#{title} - #{base_title}" :  base_title
  end

  def date(datetime)
    datetime.strftime('%Y年%m月%d日')
  end

  def date_ago(date)
    seconds = (Time.zone.now - date).floor

    years = seconds / (60 * 60 * 24 * 365)
    return "#{years}年前" if years.positive?

    days = seconds / (60 * 60 * 24)
    return "#{days}日前" if days.positive?

    hours = seconds / (60 * 60)
    return "#{hours}時間前" if hours.positive?

    minutes = seconds / 60
    return "#{minutes}分前" if minutes.positive?

    return "#{seconds}秒前"
  end

  def google_book_thumbnail(google_book)
    google_book['volumeInfo']['imageLinks'].nil? ? 'sample.png' : google_book['volumeInfo']['imageLinks']['thumbnail']
  end

  def set_google_book_params(google_book)
    google_book['volumeInfo']['bookImage'] = google_book.dig('volumeInfo', 'imageLinks', 'thumbnail')
    google_book['volumeInfo'].slice('title', 'authors', 'publishedDate', 'infoLink', 'bookImage')
  end
end
