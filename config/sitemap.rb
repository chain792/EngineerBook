# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://engineer-book.herokuapp.com"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.sitemaps_host = "https://s3-ap-northeast-1.amazonaws.com/#{ENV['AWS_S3_BUCKET_NAME']}/"

SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
  ENV['AWS_S3_BUCKET_NAME'],
  aws_region: 'ap-northeast-1',
  aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
)

SitemapGenerator::Sitemap.create do
  Book.find_each do |book|
    add book_path(book), :lastmod => book.updated_at
  end
end
