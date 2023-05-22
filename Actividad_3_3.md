Created By:  David Medina (A01783155)


# Grammars
## Module and Function

### BNF

    '''bnf - Module

        <module> ::= defmodule <module_id> do <code> end

        <module_id> ::= <uppercase> <module_id_end>
        <module_id_end> ::= <module_id_end> <module_id_end>
                            | λ
                            | <letters>

        code ::= <function> '\n' <function>
                | λ
                | <variable>
    '''

    '''bnf - Function

        <function> :: = <function_header>

        <function_header> ::= <def_defp> <function_id> '(' <parameters> ')' <function_end>
        <def_defp> ::= 'def' | 'defp'

        <function_end> :: = 'do' '\n' <code> '\n' 'end' | ', ''do:' '\n' <code_line> | <guard> ',' 'do:' '\n' <code>

    '''


### EBNF

    '''EBNF - Module

        MODULE ::= 'defmodule' UPPERCASE_ID 'do' '\n' [{CODE}] '\n' 'end'
        
        MODULE_ID ::= UPPERCASE [{(LETTERS | '_')}]

        CODE ::= [{FUNCTION}] [VARIABLE]

    '''EBNF - Function
        
        FUNCTION ::= FUNCTION_HEADER (FUNCTION_DO_END | FUNCTION_DO | FUNCTION_DO_GUARDS)

        FUNCTION_HEADER ::= ('def' | 'defp') FUNCTION_ID '(' [PARAMETERS | NUM | BOOLS] ')' 
        FUNCTION_DO_END ::= 'do' '\n' [{CODE}] '\n' 'end'
        FUNCTION_DO ::= ',' 'do:' '\n' [{CODE_LINE}]
        FUNCTION_DO_GUARDS ::= GUARD ',' 'do:' '\n' [{CODE_LINE}]

    '''