# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://engineer-book.herokuapp.com"

SitemapGenerator::Sitemap.create do
  Book.find_each do |book|
    add book_path(book), :lastmod => book.updated_at
  end
end
