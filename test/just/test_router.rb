require 'test/unit'
require 'just/router'

class PostsController

  def index
    'hello!'
  end

end

class Router
  extend Just::Router
  get '/' do
    PostsController.new.index
  end
end

class RouterTest < Test::Unit::TestCase
  def test_basic_get
    assert_equal 'hello!', Router.get('/')
  end
end