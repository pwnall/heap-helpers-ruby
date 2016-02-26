require 'helper'

class ClientTest < MiniTest::Test
  def setup
    @heap = HeapAPI::Client.new
  end

  def test_default_js_options
    assert_equal({}, @heap.js_options)
  end

  def test_js_options_setter
    @heap.js_options = { :force_ssl => true }
    assert_equal({ :force_ssl => true }, @heap.js_options)
  end

  def test_invalid_js_options
    exception = assert_raises ArgumentError do
      @heap.js_options = { :derp => true }
    end
    assert_equal ArgumentError, exception.class
    assert_equal 'Invalid heap.js advanced option :derp', exception.message
  end
  def test_constructor_options
    heap = Heap.new :app_id => 'test-app-id',
                    :js_options => { :force_ssl => true }
    assert_equal 'test-app-id', heap.app_id
    assert_equal({ :force_ssl => true }, heap.js_options)
  end
end
