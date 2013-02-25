module SampleApp

  class Post
    include Virtus

    module Views
      class Index
        def to_html
          'hello!'
        end
      end

      class Show
        include Virtus
        attribute :post, Post
        attribute :params

        def to_html
          "hello #{params[:name]}"
        end

      end

      class Create
        include Just::View
        include ActiveModel::Validations
        include Virtus
        attribute :title
        validates_presence_of :title

        def to_html
          "Creating #{title}"
        end
      end
    end
  end

  class Router
    extend Just::Router
    get '/' do
      PostsController.new.index
    end

    get /posts\/(?<name>[[:alnum:]]*)/ do |params|
      PostsController.new(:params => params).show
    end

    post '/posts' do |params|
      PostsController.new(:params => params).create
    end

    put /posts\/(?<id>[[:alnum:]]*)/ do |params|
      PostsController.new(:params => params).update
    end
  end

  class App
    extend Just::Application
    router Router
  end

  class PostsController
    include Just::Controller

    def index
      Post::Views::Index.new.to_html
    end

    def show
      Post::Views::Show.new(:params => params).to_html
    end

    def create
      view = Post::Views::Create.new(params[:post])
      if view.valid?
        view.to_html
      else
        'Invalid'
      end
    end

    def update
      "Updating #{params[:id]} with Title #{params[:post][:title]}"
    end
  end
end