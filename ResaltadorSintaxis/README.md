# Syntax Highlighter of a Python program, normal and parallel version
### Authors
- David Medina Domínguez (A01783155)
- Angel Afonso Castellanos (A01782545)

## Summary
In this activity we can show how we can 

## Table of Contents

- [Syntax Highlighter of a Python program, normal and parallel version](#syntax-highlighter-of-a-python-program-normal-and-parallel-version)
    - [Authors](#authors)
  - [Summary](#summary)
  - [Table of Contents](#table-of-contents)
  - [Manual de Usuario](#manual-de-usuario)
  - [Time Analysis](#time-analysis)
    - [Test #1](#test-1)
    - [Test #2](#test-2)
    - [Test #3](#test-3)
    - [Test #4](#test-4)


## Manual de Usuario

To run this code, you need the following elements installed:

* Erlang
* Elixir

Then we need to be and have the the scripts that are within this folder, which are going to be used to highlight the contents within:

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



## Time Analysis

<!-- ![Time difference between secuencial and parallel approach](./Primes_test.png) -->

### Test #1

<div style="text-align: center;">
<img src="./Primes_test1.png" alt="Time difference between secuencial and parallel approach" style="max-width: 80%;">
</div>

### Test #2

<div style="text-align: center;">
<img src="./Primes_test2.png" alt="Time difference between secuencial and parallel approach" style="max-width: 80%;">
</div>

### Test #3

<div style="text-align: center;">
<img src="./Primes_test3.png" alt="Time difference between secuencial and parallel approach" style="max-width: 80%;">
</div>


As we can see in the images provided before, there are three tests that take the same parameters to observe any anomalies not taken into account while the functions were being processed. 

As we can see, the secuencial approach takes an average of 2.556279666 seconds more to compleate the task than with the parallel approach.

A thing to take into mind is that the parallel approach form the tests above is working with 16 cores to achieve the task. But if we want, we can also indicate the cores to use and the prime starting number in the sum_primes_parallel/3 function.

### Test #4

<div style="text-align: center;">
<img src="./Primes_test4.png" alt="Time difference between secuencial and parallel approach" style="max-width: 80%;">
</div>

Finally, we can observe from the test #4 that while increasing the number of cores to work with, the time that it takes the program to finish diminishes.