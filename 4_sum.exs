defmodule MyMod do
  def sum([]) do
    0
  end

  def sum([head | tail]) do
    head + sum(tail)
  end
end

IO.puts(MyMod.sum([1,2,3,4]))
