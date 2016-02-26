require 'helper'

class HeapTest < MiniTest::Test
  def test_heap_js_options
    assert_equal({}, Heap.js_options)
  end
end
