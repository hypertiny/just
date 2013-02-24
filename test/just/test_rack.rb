require "rack/test"

require 'test_helper'
require 'sample_app'

class RackTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    SampleApp::App
  end

  def test_basic_get
    get('/')
    assert_equal 'hello!', last_response.body
  end

  def test_get_with_url_params
    assert_equal 'hello Paul', SampleApp::App.get('/posts/Paul')
  end

  def test_post
    assert_equal 'Creating Paul', SampleApp::App.post('/posts', {:post => {:title => 'Paul'}})
  end

  def test_put
    assert_equal 'Updating 1 with Title Paul', SampleApp::App.put('/posts/1', {:post => {:title => 'Paul'}})
  end
end