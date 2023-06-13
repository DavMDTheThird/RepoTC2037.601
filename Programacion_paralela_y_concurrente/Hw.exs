#
# Regresa la suma de todos los primos menores al limite, calculada de forma secuencial
#
# 2023-06-23

defmodule Hw.Primes do

  #---------------------------------------------------------------------------------------------------------
  #------------------------------Implementación calculada de forma secuencial-------------------------------
  #---------------------------------------------------------------------------------------------------------


  def prime(num), do: do_prime(num)

  defp do_prime(num) when num < 2, do: false
  # defp do_prime(num) when num == 2, do: num
  # defp do_prime(num) when Enum.member?([0, 2, 4, 6, 8], rem(num, 10)), do: false
  # defp do_prime(num) when rem(num, 10) == 2, do: false
  defp do_prime(num), do: do_tail_prime(num, round(Float.ceil(:math.sqrt(num))), 2)

  defp do_tail_prime(num, _max, contador) when rem(num, contador) == 0 and num != contador, do: false
  defp do_tail_prime(num, max, contador) when contador <= max, do: do_tail_prime(num, max, contador + 1)
  defp do_tail_prime(num, _max, _contador), do: num

  def sum_primes(limit) do
    _range = 0..limit
    |> Enum.map(&prime/1)
    |> Enum.filter(&(&1 != false))
    |> Enum.sum()

  end


  #---------------------------------------------------------------------------------------------------------
  #------------------------------Implementación con paralelismo y concurrencia------------------------------
  #---------------------------------------------------------------------------------------------------------

  defp ranges(primes_limit, cores, primes_start) do
    range = (primes_limit - primes_start) / cores
      |> Float.ceil()
      |> round()

    do_ranges(primes_limit, primes_start, range, [])
      # |> IO.inspect(label: "Ranges list: ")
      |> Enum.map(&Task.await(&1, 30_000))
      |> Enum.to_list()
      |> Enum.sum()
  end

  defp do_ranges(primes_limit, primes_start, range, tuples_list) when primes_start + range >= primes_limit, do: tuples_list ++ [{primes_start, primes_limit}]
  defp do_ranges(primes_limit, primes_start, range, tuples_list),do: do_ranges(primes_limit, primes_start + range + 1, range, tuples_list ++ [{primes_start, primes_start + range}])



  # |> Enum.map(&Task.await(&1, 30_000))
  # # |> IO.inspect(label: "For result: ")
  # |> Enum.to_list()
  # |> Enum.sum()


  defp do_sum_ranges(limit_start, limit_end) do
    _range = limit_start..limit_end
    |> Enum.map(&prime/1)
    |> Enum.filter(&(&1 != false))
    |> Enum.sum()
  end

  def sum_primes_parallel(primes_limit, cores \\ System.schedulers, primes_start \\ 0), do: ranges(primes_limit, cores, primes_start)

end

# Hw.Primes.sum_primes_parallel(10, 5)
# Hw.Primes.sum_primes(10)
