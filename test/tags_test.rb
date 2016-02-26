require 'helper'

class TagsTest < MiniTest::Test
  def setup
    @heap = HeapAPI::Client.new
    @heap.app_id = 'test-app-id'
    @heap.js_options = {}
  end

  def test_javascript_tag_without_app_id
    new_client = HeapAPI::Client.new
    exception = assert_raises RuntimeError do
      new_client.javascript_tag
    end
    assert_equal RuntimeError, exception.class
    assert_equal 'Heap app_id not set', exception.message
  end

  def test_javascript_tag_with_invalid_option
    exception = assert_raises ArgumentError do
      @heap.javascript_tag :derp => true
    end
    assert_equal ArgumentError, exception.class
    assert_equal 'Invalid heap.js advanced option :derp', exception.message
  end

  def test_javascript_tag
    assert_includes @heap.javascript_tag, 'heap.load("test-app-id");'
  end

  def test_javascript_tag_is_html_safe
    buffer = ''.html_safe
    buffer << @heap.javascript_tag

    assert_match(/\A<script /, buffer)
    assert_match(/<\/script>\Z/, buffer)
    assert_includes buffer, 'heap.load("test-app-id");'
  end

  def test_javascript_tag_options
    assert_includes @heap.javascript_tag(:disable_text_capture => true),
        'heap.load("test-app-id",{disableTextCapture:true});'

    tag_text = @heap.javascript_tag :force_ssl => true, :secure_cookie => true
    assert_match(/heap\.load\("test-app-id",\{.*\}\);/, tag_text)
    match = /heap\.load\("test-app-id",\{(.*)\}\);/.match tag_text
    assert_includes(['forceSSL:true,secureCookie:true',
        'secureCookie:true,forceSSL:true'], match[1])
  end

  def test_javascript_tag_default_options
    @heap.js_options = { :disable_text_capture => true }
    assert_includes @heap.javascript_tag,
        'heap.load("test-app-id",{disableTextCapture:true});'

    @heap.js_options = { :force_ssl => true }
    tag_text = @heap.javascript_tag :secure_cookie => true
    assert_match(/heap\.load\("test-app-id",\{.*\}\);/, tag_text)
    match = /heap\.load\("test-app-id",\{(.*)\}\);/.match tag_text
    assert_includes(['forceSSL:true,secureCookie:true',
        'secureCookie:true,forceSSL:true'], match[1])
  end
end
