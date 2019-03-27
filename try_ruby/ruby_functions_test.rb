require 'minitest/autorun'
require_relative './ruby_functions'

class RubyFunctions < Minitest::Test
  include Baz::Baba

  def test_hello
    assert_equal hello, 'Hello world'
  end

  def test_bar
    assert_equal Foo.bar, 'bar'
  end

  def test_baba_is_you
    # Baz::Baba.is_yo
    assert_equal is_you, 'is_you'
  end

  def test_private_functions
    assert_equal private_function, 'private_function'
  end
end
