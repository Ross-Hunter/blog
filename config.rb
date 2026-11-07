###
# Blog settings
###

# Time.zone = "UTC"

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = "articles/{year}-{month}-{day}-{title}.html"
  blog.taglink = "tag/{tag}.html"
  blog.layout = "post"
  # blog.summary_separator = /(READMORE)/
  blog.summary_length = 400
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

set :casper, {
  blog: {
    url: 'http://www.ross-hunter.com',
    name: 'Ross-Hunter',
    description: 'Doing the whole "software" thing.',
    date_format: '%d %B %Y',
    navigation: true,
    logo: nil # Optional
  },
  author: {
    name: 'Ross Hunter',
    bio: 'Computer Philosopher',
    location: 'Grand Rapids, MI',
    website: 'http://ross-hunter.com',
    gravatar_email: "ross-hunter@ross-hunter.com"
  },
  navigation: {
    "Home" => "/",
    "Blog" => "/blog/",
    "Podcast" => "https://thenewbestpractices.com",
    "GitHub" => "https://github.com/ross-hunter",
    "Twitter" => "https://twitter.com/ross_hunter",
    "LinkedIn" => "https://www.linkedin.com/in/rossh",
    "Soundcloud" => "https://soundcloud.com/ross-hunter-1",
    "Email" => "mailto:ross-hunter@ross-hunter.com"
  }
}

page '/feed.xml', layout: false
page '/sitemap.xml', layout: false

ignore '/partials/*'

# Per-tag Atom feeds at /tag/{tag}/feed.xml (rendered by feed.xml.builder)
ready do
  app.extensions[:blog].values.first.data.tags.each do |tag, articles|
    proxy "/tag/#{tag.downcase.parameterize}/feed.xml", '/feed.xml',
          layout: false, locals: { tagname: tag, tag_articles: articles[0..5] }
  end
end

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

activate :protect_emails

# Pretty URLs - http://middlemanapp.com/basics/pretty-urls/
activate :directory_indexes

# Middleman-Syntax - https://github.com/middleman/middleman-syntax
set :haml, { format: :html5 }
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true, strikethrough: true
activate :syntax, line_numbers: false

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # Production-specific config is now in environments/production.rb
end

# Server-specific configuration (for middleman server)
configure :server do
  # Server-specific settings can go here
end

# Production environment configuration (for middleman build -e production)
configure :production do
  # This will be combined with environments/production.rb
end
