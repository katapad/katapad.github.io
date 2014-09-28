# Slim settings
# Set slim-lang output style
Slim::Engine.set_default_options :pretty => true
# Set Shortcut
Slim::Engine.set_default_options :shortcut => {
    '#' => {:tag => 'div', :attr => 'id'},
    '.' => {:tag => 'div', :attr => 'class'},
    '&' => {:tag => 'input', :attr => 'type'}
}

# require 'animation'
require 'ceaser-easing'


###
# Blog settings
###

Time.zone = "Tokyo"

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "posts"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = "posts/{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  blog.layout = "layouts/post"
  blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  blog.default_extension = ".md"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

page "/feed.xml", layout: false

###
# Compass
###

compass_config do |config|
  # config.output_style = :compact
  config.additional_import_paths = ['source/css/lib']
  config.environment = :development
end

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
activate :automatic_image_sizes
activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'img'

#Syntax
activate :syntax, :line_numbers => true

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true

activate :sprockets
sprockets.append_path File.join root, 'bower_components'
sprockets.import_asset 'jquery'

# Build-specific configuration
configure :build do

  compass_config do |config|
    config.output_style = :compressed
    config.line_comments = false
    config.environment = :production
  end

  activate :minify_css
  activate :minify_javascript
  activate :cache_buster
  activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end


# Deploy-specific configuration
activate :deploy do |deploy|
  deploy.build_before = true # default: false


  # sftp
  require 'json'
  json = JSON.load(File.read('.ftppass'))
  ftp = json['unko.me']

  deploy.method   = :ftp
  deploy.host     = ftp['host']
  deploy.user     = ftp['user']
  deploy.password = ftp['password']
  deploy.path     = ftp['path']
end



activate :google_analytics do |ga|
  # Property ID (default = nil)
  ga.tracking_id = 'UA-12314579-3'

  # Removing the last octet of the IP address (default = false)
  ga.anonymize_ip = false

  # Tracking across a domain and its subdomains (default = nil)
  ga.domain_name = 'unko.me'

  # Tracking across multiple domains and subdomains (default = false)
  ga.allow_linker = false

  # Tracking Code Debugger (default = false)
  ga.debug = false

  # Tracking in development environment (default = true)
  ga.development = true

  # Compress the JavaScript code (default = false)
  ga.minify = false
end