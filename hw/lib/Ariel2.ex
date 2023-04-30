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
  sort a list using insert sort
  """
  def insertion_sort(list), do: do_insertion_sort(list,[])
  defp do_insertion_sort([],sorted), do: sorted
  defp do_insertion_sort([head | tail],sorted),
      do: do_insertion_sort(tail, insert(sorted , head))




end
