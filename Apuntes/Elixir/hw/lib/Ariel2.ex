#    Tests for the set of problems by Ariel Ortiz
#    Applications of the general concepts of functional programming
#
#    David Medina Domínguez
#    2022-04-25

defmodule Hw.Ariel2 do
@doc """
Insert an element into an already sorted list
"""
def insert(list, item), do: do_insert(list, item, [])

defp do_insert([], item, smaller), do:
    Enum.reverse([item | smaller])

defp do_insert([head | tail], item, smaller) when item <= head, do:
    Enum.reverse([item | smaller]) ++ [head | tail]

defp do_insert([head | tail], item, smaller), do:
    do_insert(tail, item, [head | smaller])

@doc """
Insert sort, sort a list
"""

def insertion_sort(list), do: do_insertion_sort(list, [])

defp do_insertion_sort([], sorted),
  do: sorted

defp do_insertion_sort([head | tail], sorted),
  do: do_insertion_sort(tail, insert(sorted, head))


@doc """
Recorrer a la izquierda, n numero de veces.
"""

def rotate_left(list, 0), do: list
def rotate_left([], _num), do: []

def rotate_left(list, num) when num > length(list), do: do_rotate_left(list, rem(num, length(list)), [], 0)
def rotate_left(list, num) when num < 0, do: do_rotate_left(Enum.reverse(list), rem(abs(num), length(list)), [], 1)
def rotate_left(list, num), do: do_rotate_left(list, num, [], 0)

defp do_rotate_left(list, 0, return_list, 1), do: Enum.reverse(list ++ return_list)
defp do_rotate_left(list, 0, return_list, _neg?), do: list ++ return_list
defp do_rotate_left([head|tail], num, return_list, neg?), do: do_rotate_left(tail, num-1, return_list ++ [head], neg?)


# @doc """
# obtener los factores primos de un numero
# """

# def prime_factors(num), do do_prime_factors(num,[]);

# defp do_prime_factors(1, lista_prime, 1), do: lista_prime
# defp do_prime_factors(num, lista_prime, contador), do:



end
