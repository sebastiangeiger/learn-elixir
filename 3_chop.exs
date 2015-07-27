defmodule Chop do
  def guess(needle, lower..upper) when upper - lower <= 1 do
    if needle == lower do
      IO.puts "It is #{lower}"
    else
      IO.puts "It is #{upper}"
    end
  end

  def guess(needle, lower..upper) do
    midpoint  = lower + trunc(Float.floor((upper - lower) / 2.0))
    IO.puts "Is it #{midpoint}?"
    if needle in lower..midpoint do
      guess(needle, lower..midpoint)
    else
      guess(needle, midpoint..upper)
    end
  end
end

Chop.guess(273, 1..1000)

