# JUST

It's just Ruby

## Usage

The canonical blog post setup.
```
class Router
  extend Just::Router

  resources :posts
end

class Post
  include Just::Model
end

class PostsController
  include Just::Controller

  def index
    Post::Views::Index.new.to_html
  end

  def new
    Post::Views::New.new.to_html
  end

  def create
    view = Post::Views::Create.new(params[:post])
    if view.valid?
      view.to_html
    else
      redirect_to :new
    end
  end
end

class Post::Views::Index
  def posts
    Post.all
  end

  def to_html
    ERB.new("<%- posts.each do |post| -%><%= post.title %><%- end -%>")
  end
end
```