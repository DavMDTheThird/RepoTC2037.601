defmodule Hw.Primes do
  def sum_primes(limite) do
    Enum.sum(primos(limite))
  end

  defp primos(limite) do
    Enum.filter(2..limite, &es_primo/1)
  end

  defp es_primo(numero) do
    Enum.all?(2..(div(numero, 2)), fn(divisor) -> rem(numero, divisor) != 0 end)
  end
end

# Uso del programa
limite = 1000000
suma = Hw.Primes.sum_primes(limite)
IO.puts("La suma de todos los primos menores a #{limite} es: #{suma}")
