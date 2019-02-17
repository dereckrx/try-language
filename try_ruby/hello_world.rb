# ruby hello_world.rb
#
# IntelliJ Setup:
# * You can use a Ruby SDK in place of a Java one

class Expector
  attr_reader :result

  def initialize(result)
    @result = result
  end

  def to_equal(expected)
    if result == expected
      puts('Pass')
    else
      puts("Fail: expected #{result} to equal #{expected}")
    end
  end
end

# it = -> name, &test { test.() }
# it.("passes if equal") do
#   expect.(1).to_equal.(1)
# end
lambda do |result|
  to_equal = lambda do |expected|
    if result == expected
      puts('Pass')
    else
      puts("Fail: expected #{result} to equal #{expected}")
    end
  end
  Expector.new(to_equal)
end

def it(_name)
  yield
end

def expect(result)
  Expector.new(result)
end

it('passes if equal') do
  expect(1).to_equal(1)
end

it('fails if not equal') do
  expect(1).to_equal(2)
end

module Foo
  class BarCommand
    def initialize
      dep = Expector.new(1)
      BarCommandGeneric.new(dep)
    end
  end

  class BarCommandGeneric
    def initialize(dep)
      @dep = dep
    end
  end
end
