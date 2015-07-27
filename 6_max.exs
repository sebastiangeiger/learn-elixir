defmodule MyMod do
  def max(list) do
    _max(list,nil)
  end

  defp _max([],nil) do
    nil
  end

  defp _max([],max) do
    max
  end

  defp _max([head|tail], nil) do
    _max(tail, head)
  end

  defp _max([head|tail], current_max) when head > current_max do
    _max(tail, head)
  end

  defp _max([head|tail], current_max) do
    _max(tail, current_max)
  end
end

IO.inspect(MyMod.max([]))
IO.inspect(MyMod.max([1]))
IO.inspect(MyMod.max([-1]))
IO.inspect(MyMod.max([1,2]))
IO.inspect(MyMod.max([1,3,2]))
