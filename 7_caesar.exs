defmodule MyList do
  def caesar([], _) do
    []
  end

  def caesar([head|tail], n) when n >= 0 and n <= 26 do
    new_value = rem(head - ?a + n, 26) + ?a
    [ new_value | caesar(tail, n) ]
  end

  def caesar(string, n) when n >= 0 do
    caesar(string, rem(n, 26))
  end
end

IO.puts(MyList.caesar('ryvkve', 39))
