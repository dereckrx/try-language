def hello
  return "Hello world"
end

def private_function
  a_private_function = -> { 'private_function' }

  a_private_function.call
end

module Foo
  module_function

  def bar
    'bar'
  end
end

class Baz
  module Baba
    module_function

    def is_you
      'is_you'
    end
  end
end