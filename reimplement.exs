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

defmodule MyList do
  def flatten(list) do
    flatten(list, [])
  end

  def flatten([], result) do
    result
  end

  def flatten([head | tail], result) do
    flatten(head) ++ flatten(tail)
  end

  def flatten(element, result) do
    result ++ [element]
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

defmodule MyListTest do

  use ExUnit.Case, async: true

  test "flatten" do
    assert MyList.flatten([]) == []
    assert MyList.flatten([1]) == [1]
    assert MyList.flatten([1, 2, 3]) == [1, 2, 3]
    assert MyList.flatten([1, 2, 3, 4]) == [1, 2, 3, 4]
    assert MyList.flatten([1, [[2], 3]]) == [1, 2, 3]
    assert MyList.flatten([ 1, [ 2, 3, [4] ], 5, [[[6]]]]) == [1,2,3,4,5,6]
  end
end
