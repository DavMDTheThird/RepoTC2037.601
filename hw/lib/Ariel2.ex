# Comentario

defmodule Hw.Ariel2 do

  @doc """
  Insert an element into an ready sorted list
  """
  def insert(list,n), do: do_insert(n,list,[])


  defp do_insert(n,[],res), do: Enum.reverse([n | res])
  defp do_insert(n,[head | tail],res) when n <= head,
      do: Enum.reverse([n | res]) ++ [head | tail]
  defp do_insert(n,[head | tail], res), do: do_insert(n,tail,[head | res])

  @doc """
  Sort a list using insert sort
  """
  def insertion_sort(list), do: do_insertion_sort(list,[])

  defp do_insertion_sort([],sorted), do: sorted
  defp do_insertion_sort([head | tail],sorted), do: do_insertion_sort(tail, insert(sorted , head))

  @doc """
  Rotate a list n times to the left
  La funci on rotate-left toma dos entradas: un n ́umero entero n y una lista lst. Devuelve la lista que resulta de rotar lst un total de n elementos a la izquierda. Si n es negativo, rota hacia la derecha.
  """

  def rotate_left(list, 0), do: list
  def rotate_left([], _n), do: []
  def rotate_left(list, n) when n < 0, do: do_rotate_left(Enum.reverse(list), abs(n), [], 1)
  def rotate_left(list, n), do: do_rotate_left(list, n, [], 0)

  defp do_rotate_left(list, 0, return_list, 1), do: Enum.reverse(return_list) ++ Enum.reverse(list)
  defp do_rotate_left(list, 0, return_list, 0), do: list ++ return_list
  defp do_rotate_left(list, n, return_list, neg?) when n > length(list), do: do_rotate_left(list, rem(n, length(list)), return_list, neg?)
  defp do_rotate_left([head | tail], n, return_list, neg?), do: do_rotate_left(tail, n - 1, return_list ++ [head], neg?)

  @doc """
  Return the prime factors of a number
  La funcion prime-factors toma un numero entero n como entrada (n ¿ 0) y devuelve una lista que contiene los factores primos de n en orden ascendente. Los factores primos son los numeros primos que dividen a un
  numero de manera exacta. Si se multiplican todos los factores primos se obtiene el numero original.
  """

  def prime_factors(n) when n < 2, do: []
  def prime_factors(n), do: do_prime_factors(n, 2, [])

  defp do_prime_factors(1, _c, return_list), do: insertion_sort(return_list)
  defp do_prime_factors(n, c, return_list) when rem(n, c) == 0, do: do_prime_factors(div(n, c), 2, return_list ++ [c])
  defp do_prime_factors(n, c, return_list), do: do_prime_factors(n, c + 1, return_list)

  @doc """
  Returns the Maximum common divisor of two positive numbers.
  La funcion gcd toma dos numeros enteros positivos a y b como entrada, donde a > 0 y b > 0. Devuelve el maximo comun divisor (GCD por sus siglas en ingles) de a y b. No se debe usar la funcion gcd o similar
  predefinida.
  """
  #Usando los numeros primos
  def gcd(0, 0), do: 0
  def gcd(a, 0), do: a
  def gcd(0, b), do: b
  def gcd(a, b), do: pre_gcd(prime_factors(a), prime_factors(b))

  defp pre_gcd(a, b) when length(a) >= length(b), do: do_gcd(Enum.reverse(a), Enum.reverse( b), [])
  defp pre_gcd(a, b), do: do_gcd(Enum.reverse(b), Enum.reverse(a), [])

  defp do_gcd([], _check_list, common_gcd), do: Enum.reduce(common_gcd, 1, fn(x, acc) -> x * acc end) #Esto lo tuve que buscar, y si lo entinendo, pero si le tengo que pensar :p todavia.
  defp do_gcd([head | tail], check_list, common_gcd) do
    if Enum.member?(check_list, head) do
      do_gcd(tail, remove_first(head, check_list), common_gcd ++ [head])
    else
      do_gcd(tail, check_list, common_gcd)
    end
  end

  def remove_first(n, [n | tail]), do: tail
  def remove_first(n, [head | tail]), do: [head | remove_first(n, tail)]
  def remove_first(_n, []), do: []
  #Usando el algoritmo de Euclides.... (Que nos enteramos despues :'( )
  def gcd2(0,0), do: 0
  def gcd2(a,b), do: do_gcd2(a,b)

  defp do_gcd2(a,0), do: a
  defp do_gcd2(0,b), do: b
  defp do_gcd2(a,b), do: do_gcd2(b, rem(a,b))


  @doc """
  Returns the Maximum common divisor of two positive numbers.
  La funcion encode toma una lista lst como entrada. Los elementos consecutivos en lst se codifican en listas de la forma: (n e), donde n es el numero de ocurrencias del elemento e.
  """
#Arreglar xd
  def encode([]), do: []
  def encode(list), do: do_encode(list, hd(list), 0,  [] )

  defp do_encode([], state, counter, return_list), do: return_list ++ [{counter, state}]
  defp do_encode([head | tail], state, counter, return_list) when head != state, do: do_encode(tail, hd(tail), 0, return_list ++ [{counter, head}])
  defp do_encode([head | tail], _state, counter, return_list), do: do_encode(tail, head, counter + 1, return_list)



#  def encode2(list), do: do_encode(list, [], [])
#
#  defp do_encode2([], _already, return_list), do: return_list
#  defp do_encode2([head | tail], already, return_list) do
#    if(Enum.member?(already, head)) do
#      do_encode2(tail, already, return_list)
#    else
#      do_encode2(tail, already ++ [head], return_list ++ [{Enum.count([head | tail], &(&1 == head)), head}])
#    end
#  end


  def multListPos(lista), do: do_multListPos(lista, 1, [])#

  defp do_multListPos([], multiplicador, return_list), Enum.reverse(return_list)
  defp do_multListPos([head | tail], multiplicador, return_list), do: do_multListPos(tail, multiplicador + 1, [head * multiplicador | return_list] )

end
