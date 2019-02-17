# elixir hello_world.exs
# IntellJ setup:
# * Requires SDK "Elixir 1.6.6"
log = &IO.puts/1
log.("Hello world from Elixir")

# { a, b } = { :ok, "Hi" }
# { state, message } = some_function()

sum = fn (a, b) -> a + b end
sum.(2,3)

sum = &(&1 + &2) # Shorthand
sum.(2, 3)

to_equal = fn(result, expected) ->
  if result == expected do
    log.("Pass")
  else
    log.("Fail: expected #{result} to equal #{expected}")
  end
end

expect1 = fn(result, tester, expected) ->
  tester.(result, expected)
end

it = fn(name, tester) -> tester.() end

it.("Passes if equal", fn() ->
  expect1.(1, to_equal, 1)
end
)

it.("Fails if not equal", fn() ->
  expect1.(1, to_equal, 2)
end
)

exp = fn -> IO.puts("exp") end

# Struct
defmodule Expector do
  defstruct result: 0
end

# Class Object
defmodule Car do
  # Constant
  @default_state %{
    type: "Car",
    x: 0
  }

  def new(state \\ %{}) do
    spawn_link fn ->
      Map.merge(@default_state, state) |> run
    end
  end

  defp run(state) do
    receive do
      :drive ->
        new_x = state.x + 1
        new_state = Map.put(state, :x, new_x)

        IO.puts "[#{state.type}] [#{state.color}] X .. #{state.x} -> #{new_x}"

        run(new_state)
    end
  end
end

car = Car.new(%{color: "Red"})
log.(send(car, :drive)) #=> [Car] [Red] X .. 0 -> 1
log.(send(car, :drive)) #=> [Car] [Red] X .. 1 -> 2

# defmodule Do do
#   def something do
#     do_whatever
#   end
# end

# some_function.( &Do.something/0 )

# Enum.reduce([“hello”, “ “, “world”], &(&2 <> &1))