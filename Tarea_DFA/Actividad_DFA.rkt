; Simple Deterministic Finite Automaton (DFA) to validate arithmetic expressions
; It returns a list of the types of tokens found in an expression


; David Medina 
; Angel Afonso


#lang racket

(require racket/trace)

(provide dfa arithmetic-lexer delta-arithmetic)

; Define a stucture that describes a DFA
(struct dfa (transition initial accept))

(define (arithmetic-lexer strng)
;   " Evaluate an arithmetic expression "
  (validate-dfa (dfa delta-arithmetic 'start '(int float exp id spa par_close)) strng))

; Function to evaluate a string using a DFA
; Receives the string to test and a structure for a DFA
(define (validate-dfa dfa-def input)
  (let loop
    ; Convert the string into a list of chars
    ([char-list (string->list input)]
     ; Get the initial state from the DFA definition
     [state (dfa-initial dfa-def)]
     ; The list to be returned with all the types of tokens found
     [caracter '()]
     [tokens '()])
    (cond
      ; Check if the final state is in the list of acceptable states
      [(empty? char-list)
       (if (member state (dfa-accept dfa-def))
            ; To add the last state
            (reverse (cons (list (list->string (reverse caracter)) state) tokens))
            #f)]
      [else
        ; Extract the two values returned by the transition function
        (let-values
          ;   var1      var2   Call to the transition function
          ([(new-state found) ((dfa-transition dfa-def) state (car char-list))])
          (loop
            ; New list
            (cdr char-list)
            ; New state, obtained by calling the transition function
            new-state
            ; New list of tokens. Add a token only if it has already been identified
                ; The spaces will not be added to the character display
            (if found (if (eq? #\space (car char-list)) '() (list (car char-list))) (cons (car char-list) caracter))
            (if found (cons (list (list->string (reverse caracter)) found) tokens) tokens)))])))

(define (char-operator? char)
  ; " Check if the character is considered an operator "
  (member char (string->list "=+-*/^")))

; Accept numbers of different types
; Star state: 'start
; Accept states: 'int 'float 'op_space ' par_open
; The function returns pairs of values: the new state, and the token that had been found
; if the token has not fihised yet, the type is false ( #f )
(define (delta-arithmetic state char)
  (cond
    [(eq? state 'start) (cond
       [(char-numeric? char) (values 'int #f)]
       [(or (eq? char #\+) (eq? char #\-)) (values 'sign #f)]
       [(char-alphabetic? char) (values 'id #f)]
       [(char-whitespace? char) (values 'op_spa #f)]
       [(eq? char #\_) (values 'id #f)]
       [(eq? char #\( ) (values 'par_open #f)]  
       [else (values 'inv #f)])]

    ;parentesis abrir
    [(eq? state 'par_open) (cond ;Esto es un token
       [(char-alphabetic? char) (values 'id 'par_open)]
       [(eq? char #\_) (values 'id 'par_open)]
       [(or (eq? char #\+) (eq? char #\-)) (values 'sign 'par_open)]
       [(char-numeric? char) (values 'int 'par_open)]
       [(char-whitespace? char) (values 'op_spa 'par_open)]
       [(eq? char #\( ) (values 'par_open 'par_open)]  
       [else (values 'inv #f)])]

    ;parentesis cerrar
    [(eq? state 'par_close) (cond ;Esto es un token
       [(char-operator? char)(values 'op 'par_close)]
       [(or (eq? char #\+) (eq? char #\-)) (values 'sign 'par_close)] ;Creo que nunca puede entrar a este estado (Por el de arriba)
       [(char-whitespace? char) (values 'spa 'par_close)] 
       [(eq? char #\) ) (values 'par_close 'par_close)]  
       [else (values 'inv #f)])]

    [(eq? state 'sign) (cond
       [(char-numeric? char) (values 'int #f)]
    ;    [(eq? char #\( ) (values 'par_open 'par_open)]  
       [else (values 'inv #f)])]

    [(eq? state 'int) (cond
       [(char-numeric? char) (values 'int #f)]
       [(eq? char #\.) (values 'dot #f)]
       [(or (eq? char #\e) (eq? char #\E)) (values 'e #f)]
       [(char-operator? char) (values 'op 'int)]
       [(char-whitespace? char) (values 'spa 'int)]
       [(eq? char #\) ) (values 'par_close 'int)]   
       [else (values 'inv #f)])]

    [(eq? state 'dot) (cond
       [(char-numeric? char) (values 'float #f)]
       [else (values 'inv #f)])]

    [(eq? state 'float) (cond
       [(char-numeric? char) (values 'float #f)]
       [(or (eq? char #\e) (eq? char #\E)) (values 'e #f)]
       [(char-operator? char) (values 'op 'float)]
       [(char-whitespace? char) (values 'spa 'float)]
       [(eq? char #\) ) (values 'par_close 'float)]  
       [else (values 'inv #f)])]

    [(eq? state 'e) (cond
       [(char-numeric? char) (values 'exp #f)]
       [(or (eq? char #\+) (eq? char #\-)) (values 'e_sign #f)]
       [else (values 'inv #f)])]

    [(eq? state 'e_sign) (cond
       [(char-numeric? char) (values 'exp #f)]
       [else (values 'inv #f)])]

    [(eq? state 'exp) (cond
       [(char-numeric? char) (values 'exp #f)]
       [(char-operator? char) (values 'op 'exp)]
       [(char-whitespace? char) (values 'spa 'exp)]
       [(eq? char #\) ) (values 'par_close 'exp)]  
       [else (values 'inv #f)])]

    [(eq? state 'id) (cond
       [(char-numeric? char) (values 'id #f)]
       [(char-alphabetic? char) (values 'id #f)]
       [(eq? char #\_) (values 'id #f)]
       [(char-operator? char) (values 'op 'id)]
       [(char-whitespace? char) (values 'spa 'id)]
       [(eq? char #\) ) (values 'par_close 'var)]  
       [(eq? char #\( ) (values 'par_open 'var)]  
       [else (values 'inv #f)])]

    [(eq? state 'op) (cond
        [(char-numeric? char) (values 'int 'op)]
        [(or (eq? char #\+) (eq? char #\-)) (values 'sign 'op)]
        [(char-alphabetic? char) (values 'id 'op)]
        [(char-whitespace? char) (values 'op_spa 'op)]
        [(eq? char #\( ) (values 'par_open 'op)] 
        [(eq? char #\_) (values 'id 'op)] 
        [else (values 'inv #f)])]

    [(eq? state 'spa) (cond
       [(char-operator? char) (values 'op #f)]
       [(char-whitespace? char) (values 'spa #f)]
       [(eq? char #\) ) (values 'par_close #f)]  
       [(eq? char #\( ) (values 'par_open #f)]   
        [(eq? char #\_) (values 'id #f)] 
       [else (values 'inv #f)])]

    [(eq? state 'op_spa) (cond
       [(char-numeric? char) (values 'int #f)]
       [(or (eq? char #\+) (eq? char #\-)) (values 'sign #f)]
       [(char-alphabetic? char) (values 'id #f)]
       [(eq? char #\_) (values 'id #f)]
       [(char-whitespace? char) (values 'op_spa #f)]
       [(eq? char #\( ) (values 'par_open #f)] 
       [else (values 'inv #f)])]
    [else (values 'inv #f)]
    ))



; (equal? (arithmetic-lexer "2") '(int)) ; "Single digit"
; (equal? (arithmetic-lexer "261") '(int)) ; "Multi digit int"
; (equal? (arithmetic-lexer "2+1") '(int op int)) ; "Binary operation"
; (equal? (arithmetic-lexer "2 + 1") '(int op int)) ; "Binary operation with spaces"
; (equal? (arithmetic-lexer "6 = 2 + 1") '(int op int op int)) ; "Multiple operators"
; (equal? (arithmetic-lexer "97 /6 = 2 + 1") '(int op int op int op int)) ; "Multiple operators"
; (equal? (arithmetic-lexer " 2 + 1 ") '(int op int)) ; "Spaces before and after"
; Falta añadir el espacio al principio.
; Test 2
; (equal? (arithmetic-lexer "2") '(("2" int))) ; "Single digit"