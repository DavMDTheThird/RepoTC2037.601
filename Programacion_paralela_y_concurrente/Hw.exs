# Regresa la suma de todos los primos menores al limite, calculada de forma secuencial y calculada de forma paralela.
#
# Hecho por:
# David Medina Domínguez A01783155
# Angel Afonso
#
# 2023-06-23

defmodule Hw.Primes do

  #---------------------------------------------------------------------------------------------------------
  #------------------------------Implementación calculada de forma secuencial-------------------------------
  #---------------------------------------------------------------------------------------------------------


  def prime(num), do: do_prime(num)

  # Check if a number is prime
  defp do_prime(num) when num < 2, do: false
  defp do_prime(num), do: do_tail_prime(num, round(Float.ceil(:math.sqrt(num))), 2)

  # Tail function to recursively check if a number is prime
  defp do_tail_prime(num, _max, contador) when rem(num, contador) == 0 and num != contador, do: false
  defp do_tail_prime(num, max, contador) when contador <= max, do: do_tail_prime(num, max, contador + 1)
  defp do_tail_prime(num, _max, _contador), do: num

  # Entry point function for calculating the sum of primes
  def sum_primes(limit) do
    _range = 0..limit
      |> Enum.map(&prime/1)
      |> Enum.filter(&(&1 != false))  # Filter out any numbers that are not prime
      |> Enum.sum()  # Calculate the sum of the prime numbers
      |> IO.inspect(label: "Sum of primes: ")
  end


  #---------------------------------------------------------------------------------------------------------
  #------------------------------Implementación con paralelismo y concurrencia------------------------------
  #---------------------------------------------------------------------------------------------------------

  defp ranges(primes_limit, cores, primes_start) do
    # Calculate the range size for each core based on the total number of primes and the number of cores
    range = (primes_limit - primes_start) / cores
             |> Float.ceil()
             |> round()

    # Generate a list of tuples with the according ranges of primes to be processed
    do_ranges(primes_limit, primes_start, range, [])
      # Asynchronously calculate the sum of primes for each range in parallel
      |> Enum.map(&Task.async(fn -> do_sum_ranges(&1) end))
      # Wait for all tasks to complete and obtain their results
      |> Enum.map(&Task.await(&1, 30_000))
      # Calculate the total sum of primes from the given cores
      |> Enum.sum()
      |> IO.inspect(label: "Sum of primes: ")
  end

  # Generate a list of tuples representing the ranges of primes to be processed recursively.
  defp do_ranges(primes_limit, primes_start, range, tuples_list) when primes_start + range >= primes_limit, do: tuples_list ++ [{primes_start, primes_limit}]
  defp do_ranges(primes_limit, primes_start, range, tuples_list), do: do_ranges(primes_limit, primes_start + range + 1, range, tuples_list ++ [{primes_start, primes_start + range}])

  # Calculate the sum of primes within a given range
  defp do_sum_ranges(tuple) do
    {limit_start, limit_end} = tuple
    _range = limit_start..limit_end
    |> Enum.map(&prime/1)
    |> Enum.filter(&(&1 != false))  # Filter out non prime numbers (that are given as false)
    |> Enum.sum()  # Calculate the sum of the prime numbers
  end

  # Entry point function for calculating the sum of primes in parallel
  def sum_primes_parallel(primes_limit, cores \\ System.schedulers, primes_start \\ 0), do: ranges(primes_limit, cores, primes_start)

end

# Pruebas en terminal:

# Hw.Primes.sum_primes_parallel(10, 5)
# Hw.Primes.sum_primes(10)

# System.schedulers
# :timer.tc(fn -> Hw.Primes.sum_primes(5_000_000)  end) |> elem(0) |> Kernel./(1_000_000)
# :timer.tc(fn -> Hw.Primes.sum_primes_parallel(5_000_000) end) |> elem(0) |> Kernel./(1_000_000)
