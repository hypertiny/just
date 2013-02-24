require 'test_helper'

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
end

class RouterTest < Test::Unit::TestCase
  def test_basic_get
    assert_equal 'hello!', App.get('/')
  end

  def test_get_with_url_params
    assert_equal 'hello Paul', App.get('/posts/Paul')
  end

  def test_post
    assert_equal 'Creating Paul', App.post('/posts', {:post => {:title => 'Paul'}})
  end

  def test_put
    assert_equal 'Updating 1 with Title Paul', App.put('/posts/1', {:post => {:title => 'Paul'}})
  end
end