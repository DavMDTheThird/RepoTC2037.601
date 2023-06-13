defmodule Primes do

  def is_prime(n) when n <= 1, do: false

  def is_prime(n) when rem(n, 2) == 0, do: n == 2

  def is_prime(n) do
    Enum.all?(2..trunc(:math.sqrt(n)), fn(x) -> rem(n, x) != 0 end)
  end

  def sum_primes_sequential(n) do
    Enum.filter(2..n, &is_prime/1)
    |> Enum.sum()
  end

end

# Uso del programa
start_time = :os.system_time(:millisecond)
result = Primes.sum_primes_sequential(5_000_000)
end_time = :os.system_time(:millisecond)
execution_time = end_time - start_time

IO.puts "La suma de los números primos menores a 5,000,000 es #{result}. y se realizó en #{execution_time}."
