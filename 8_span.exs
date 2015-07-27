defmodule MyList do
  def span(done, done) do
    [done]
  end

  def span(from, to) do
    [from | span(from + 1, to)]
  end
end

IO.inspect(MyList.span(5,11))
