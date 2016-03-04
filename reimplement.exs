ExUnit.start

defmodule MyEnum do
  def all?(collection, function) do
    all?(collection, function, true)
  end

  def all?([head | tail], function, result) do
    all?(tail, function, result && function.(head))
  end

  def all?([], _function, result) do
    result
  end

  def all?(_collection, _function, false) do
    false
  end
end

defmodule MyEnumTest do

  use ExUnit.Case, async: true

  test "all?" do
    assert MyEnum.all?([2, 4, 6], fn(x) -> rem(x, 2) == 0 end)
    refute MyEnum.all?([2, 3, 4], fn(x) -> rem(x, 2) == 0 end)
    assert MyEnum.all?([], fn(x) -> rem(x, 2) == 0 end)
  end
end
