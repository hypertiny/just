module SampleApp
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
      'hello!'
    end

    def show
      "hello #{params[:name]}"
    end

    def create
      "Creating #{params[:post][:title]}"
    end

    def update
      "Updating #{params[:id]} with Title #{params[:post][:title]}"
    end
  end
end