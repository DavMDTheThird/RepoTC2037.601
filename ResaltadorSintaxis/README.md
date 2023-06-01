# Resaltador de Sintáxis de un programa de Python - Manual

### Names:
- David Medina Domínguez (A01783155)
- Angel Afonso Castellanos (A01782545)

## Manual de Usuario

Para poder correr este codigo es necesario tener instalado:

* Erlang
* Elixir

Finalmente, se requiere estar dentro del mismo directorio donde estan los archivos a correr.
Despues ingresar en la terminal:

```{terminal}
    iex Reto.exs
```

Ya estamos dentro de el codigo de elixir, por lo que puedes hacer cualquier funcionalidad de este.

Despues corremos en la terminal R.pylexic(), el cual es una funcion del modulo "R" y una funcion publica llamada "pylexic".

```{elixir}
    iex(1)> R.pylexic("test1.py","test1_answear.html")
```

Como se puede observar, se le tienen que netregar dos parametros:
* El primero siendo el nombre exacto del archivo a evaluar
* Y el segundo unicamente sera el nombre del nuevo archivo donde se guardarán todos los efectos de "pylexic". El cual genera un html con el codigo del otro archivo entregado.