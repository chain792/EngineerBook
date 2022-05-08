module ApplicationHelper
  def page_title(title = '')
    base_title = 'EngineerBook'
    title.present? ? "#{title} - #{base_title}" :  base_title
  end

  def date(datetime)
    datetime.strftime('%Y年%m月%d日')
  end

  def google_book_thumbnail(google_book)
    google_book['volumeInfo']['imageLinks'].nil? ? 'sample.png' : google_book['volumeInfo']['imageLinks']['thumbnail']
  end

  def set_google_book_params(google_book)
    google_book['volumeInfo']['bookImage'] = google_book.dig('volumeInfo', 'imageLinks', 'thumbnail')
    google_book['volumeInfo'].slice('title', 'authors', 'publishedDate', 'infoLink', 'bookImage')
  end

end
