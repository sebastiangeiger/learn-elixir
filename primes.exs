ExUnit.start

defmodule MyList do
  def span(done, done) do
    [done]
  end

  def span(from, to) do
    [from | span(from + 1, to)]
  end
end

defmodule Primes do
  def upto(n) do
    MyList.span(2,n)
      |> Enum.filter(&(Primes.is_prime?(&1)))
  end

  def is_composite?(2) do
    false
  end

  def is_composite?(x) when x < 2 do
    true
  end

  def is_composite?(x) do
    MyList.span(2, x-1)
     |> Enum.any?(&(rem(x, &1) == 0))
  end

  def is_prime?(x) do
    not is_composite?(x)
  end
end

defmodule MyListTest do

  use ExUnit.Case, async: true

  test "span" do
    assert MyList.span(2, 3-1) == [2]
  end
end

defmodule PrimesTest do

  use ExUnit.Case, async: true

  test "is_prime?" do
    assert Primes.is_prime?(2)
    assert Primes.is_prime?(3)
    assert Primes.is_prime?(5)
    assert Primes.is_prime?(7)

    refute Primes.is_prime?(0)
    refute Primes.is_prime?(1)
    refute Primes.is_prime?(4)
    refute Primes.is_prime?(6)
  end

  test "upto" do
    assert Primes.upto(2) == [2]
    assert Primes.upto(3) == [2,3]
    assert Primes.upto(5) == [2,3,5]
  end
end
