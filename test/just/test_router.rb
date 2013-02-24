require 'test_helper'

class PostsController
  include Just::Controller

  def index
    'hello!'
  end

  def show
    "hello #{params[:name]}"
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
end

class RouterTest < Test::Unit::TestCase
  def test_basic_get
    assert_equal 'hello!', Router.get('/')
  end

  def test_get_with_params
    assert_equal 'hello Paul', Router.get('/posts/Paul')
  end
end