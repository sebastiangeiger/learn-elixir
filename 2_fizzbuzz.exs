one = fn
  0, 0, _ -> "FizzBuzz"
  _, 0, _ -> "Fizz"
  0, _, _ -> "Buzz"
  _, _, a -> a
end

fizz_buzz = fn
  x -> IO.puts one.(rem(x,3), rem(x,5), x)
end

fizz_buzz.(10)
fizz_buzz.(11)
fizz_buzz.(12)
fizz_buzz.(13)
fizz_buzz.(14)
fizz_buzz.(15)
fizz_buzz.(16)
fizz_buzz.(17)
