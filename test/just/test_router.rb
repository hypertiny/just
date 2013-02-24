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
    "Saving #{params[:post][:title]}"
  end
end

class Router
  extend Just::Router
  get '/' do
    PostsController.new.index
  end

  get /posts\/(?<name>[[:alnum:]]*)/ do |matches|
    PostsController.new(:route_params => matches).show
  end

  post '/posts' do |params|
    PostsController.new(:params => params).create
  end
end

class App
  extend Just::Application
end

class RouterTest < Test::Unit::TestCase
  def test_basic_get
    assert_equal 'hello!', App.get('/')
  end

  def test_get_with_params
    assert_equal 'hello Paul', App.get('/posts/Paul')
  end

  def test_post
    assert_equal 'Saving Paul', App.post('/posts', {:post => {:title => 'Paul'}})
  end
end