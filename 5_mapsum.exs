defmodule MyMod do
  def sum([]) do
    0
  end

  def sum([head | tail]) do
    head + sum(tail)
  end

  def map([], _) do
    []
  end

  def map([head|tail], fun) do
    [fun.(head) | map(tail, fun)]
  end

  def mapsum(list, fun) do
    list
      |> map(fun)
      |> sum
  end
end

IO.puts(MyMod.mapsum([1,2,3], &(&1 * &1)))
