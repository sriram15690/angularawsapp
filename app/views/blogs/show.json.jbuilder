json.extract! @blog, :title,:content,:author, :updated_at

json.updated_at(@blog.updated_at.strftime('%d/%m/%Y'))