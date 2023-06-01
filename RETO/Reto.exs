# Work with text files
# Using regular expressions
# Identify the regular expresions of python
#
# David Medina A01783155
# Angel Afonso A01782545
# 2023-05-31

defmodule R do
  @reserved_words ~r/^import|^False|^True|^if|^elif|^else|^for|^while|^break|^try|^catch|^def|^return|^class/ #Some reserved words
  @operators ~r/^\+|^\-|^\*|^\/|^\%|^\=|^\=\=|^\!\=|^\<|^\>|^\<\=|^\>\=|^and|^or|^not|^in|^is/ # Some operators
  @numbers ~r/^-?\d+|^-?\d+\.\d+|^-?\d+(\.\d+)?[eE][+-]?\d+/ #int,float,scientific numbers
  @functions ~r/^print|^input|^len|^range|^open|^str|^int|^float|^list|^dict/ # Some built in functions
  @punctuation ~r/^\(|^\)|^\[|^\]|^\{|^\}|^\:|^\,|^\./ # Some punctuations
  @strings ~r/^".+"|^'.+'/ # Strings
  @comments ~r/^#.*$/ # Comments
  @spaces ~r/^\s+/ # White Spaces, tabs and newlines
  @variables ~r/^[a-zA-Z_][a-zA-Z0-9_]*/ # Variable names in python

  @st_html "\t\<span class\=\""
  @md_html "\"\>"
  @nd_html "\<\/span\>\n"
  @html_st '<!DOCTYPE html>\n<html lang="en">\n<head>\n\t<meta charset="UTF-8">\n\t<meta http-equiv="X-UA-Compatible" content="IE=edge">\n\t<meta name="viewport" content="width=device-width, initial-scale=1.0">\n\t<link rel="stylesheet" href="../RETO/tests.css">\n\t<title>Test Resaltador de Python</title>\n</head>\n<body>\n'
  @html_nd '</body>\n</html>'


  def pylexic(in_filename, out_filename) do
    {time, _result} = :timer.tc(fn ->
    data = in_filename
          |> File.stream!() # Read the file, line by line
          |> Enum.map(&python_token(&1)) # Call a function with each line read
          # |> Enum.to_list()
          # |> IO.inspect()
          |> Enum.join("\<br\>\n")

    File.write(out_filename, Enum.join([@html_st, data, @html_nd])) # Store the results in a new file
    end)
    IO.puts("Tiempo de ejecucion: #{time} microsegundos")
  end

  defp python_token(line), do: do_python_token(line, [])

  defp do_python_token("", rtline), do: Enum.reverse(rtline)

  defp do_python_token(line, rtlist) do
    cond do
      Regex.match?(@spaces, line) -> # Eliminar espacios
        line = Regex.replace(@spaces, line, "")
        do_python_token(line, rtlist)


      Regex.match?(@reserved_words, line) ->
        match = Regex.run(@reserved_words, line, capture: :first)
        line = Regex.replace(@reserved_words, line, "")
        new_line = Enum.join([@st_html, "reserved_word", @md_html, List.first(match), @nd_html])
        do_python_token(line, [new_line|rtlist])


      Regex.match?(@functions, line) ->
        match = Regex.run(@functions, line, capture: :first)
        line = Regex.replace(@functions, line, "")
        new_line = Enum.join([@st_html, "function", @md_html, List.first(match), @nd_html])
        do_python_token(line, [new_line|rtlist])


      Regex.match?(@punctuation, line) ->
        match = Regex.run(@punctuation, line, capture: :first)
        line = Regex.replace(@punctuation, line, "")
        new_line = Enum.join([@st_html, "punctuation", @md_html, List.first(match), @nd_html])
        do_python_token(line, [new_line|rtlist])


      Regex.match?(@strings, line) ->
        match = Regex.run(@strings, line, capture: :first)
        line = Regex.replace(@strings, line, "")
        new_line = Enum.join([@st_html, "string", @md_html, List.first(match), @nd_html])
        do_python_token(line, [new_line|rtlist])


      Regex.match?(@numbers, line) ->
        match = Regex.run(@numbers, line, capture: :first)
        line = Regex.replace(@numbers, line, "")
        new_line = Enum.join([@st_html, "number", @md_html, List.first(match), @nd_html])
        do_python_token(line, [new_line|rtlist])


      Regex.match?(@operators, line) ->
        match = Regex.run(@operators, line, capture: :first)
        line = Regex.replace(@operators, line, "")
        new_line = Enum.join([@st_html, "operator", @md_html, List.first(match), @nd_html])
        do_python_token(line, [new_line|rtlist])


      Regex.match?(@variables, line) ->
        match = Regex.run(@variables, line, capture: :first)
        line = Regex.replace(@variables, line, "")
        new_line = Enum.join([@st_html, "variable", @md_html, List.first(match), @nd_html])
        do_python_token(line, [new_line|rtlist])


      Regex.match?(@comments, line) ->
        match = Regex.run(@comments, line, capture: :first)
        line = Regex.replace(@comments, line, "")
        new_line = Enum.join([@st_html, "comment", @md_html, List.first(match), @nd_html])
        do_python_token(line, [new_line|rtlist])

      true ->
        IO.puts("EL REGEX NO FUE ENCONTRADO")
        IO.puts(line)
        Enum.reverse(rtlist)

    end

  end

end

# R.pylexic("test1.py","test1_answear.html")
# R.pylexic("test2.py","test2_answear.html")
# R.pylexic("test3.py","test3_answear.html")
