require 'test_helper'
require 'sample_app'

class RouterTest < Test::Unit::TestCase
  def test_invalid_post
    assert_equal 'Invalid', SampleApp::App.post('/posts', {:post => {:title => ''}})
  end
end