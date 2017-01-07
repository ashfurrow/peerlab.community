set :relative_links, true

activate :directory_indexes

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
end
