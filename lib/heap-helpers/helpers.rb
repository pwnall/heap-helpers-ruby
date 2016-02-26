# Helper tags.
module HeapAPI::Helpers
  # Generates a <script> tag that includes and configures heap.js.
  #
  # The tag should be inserted before the closing </head> tag on each page of
  # the site.
  #
  # @param options [Hash] advanced configuration for heap.js
  # @option options [Boolean] :force_ssl when set to true, heap.js will only
  #   use SSL to send data to our collection endpoints; defaults to false
  # @option options [Boolean] :secure_cookie when set to true, user cookies in
  #   heap.js will only be transmitted via SSL; defaults to false
  # @option options [Boolean] :disable_text_capture when set to true, heap.js
  #   will not capture the text content of elements; defaults to false
  # @return {ActiveSupport::SafeBuffer} <script> tag that includes and
  #   configures heap.js
  # @see https://heapanalytics.com/docs/installation#web
  def javascript_tag(options = {})
    ensure_valid_app_id!
    app_string = app_id.inspect

    option_strings = []
    options.merge(js_options).each do |key, value|
      unless js_key = JS_OPTIONS[key]
        raise ArgumentError, "Invalid heap.js advanced option #{key.inspect}"
      end
      option_strings << "#{js_key}:#{!!value}"
    end

    if option_strings.empty?
      js_args = app_string
    else
      js_args = "#{app_string},{#{option_strings.join(',')}}"
    end

    JS_SNIPPET.join(js_args).html_safe
  end

  # @return [Hash<Symbol, Object>] default heap.js advanced options
  # @see HeapAPI::Client#javascript_tag
  attr_accessor :js_options

  def js_options
    @js_options ||= {}
  end

  def js_options=(new_options)
    new_options.each do |key, value|
      unless JS_OPTIONS[key]
        raise ArgumentError, "Invalid heap.js advanced option #{key.inspect}"
      end
    end
    @js_options = new_options
  end

  # The fragments that make up the Heap JS snippet.
  JS_SNIPPET = File.read(File.join(File.dirname(__FILE__), 'snippet.js')).
                    split('$$args')

  # Maps Ruby-esque snake_case heap.js options to JS-esque CamelCase options.
  JS_OPTIONS = {
    :force_ssl => 'forceSSL',
    :secure_cookie => 'secureCookie',
    :disable_text_capture => 'disableTextCapture',
  }
end
