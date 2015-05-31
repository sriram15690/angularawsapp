json.blogs @blogs do |blog|
  json.(blog,:id,:title,:content,:author, :updated_at)
  json.updated_at(blog.updated_at.strftime('%d/%m/%Y'))
end