#! /usr/bin/env gforth

\ Challenge 095
\
\ TASK #2 › Demo Stack
\ Submitted by: Mohammad S Anwar
\ Write a script to demonstrate Stack operations like below:
\
\ push($n) - add $n to the stack
\ pop() - remove the top element
\ top() - get the top element
\ min() - return the minimum element
\
\ Example:
\ my $stack = Stack->new;
\ $stack->push(2);
\ $stack->push(-1);
\ $stack->push(0);
\ $stack->pop;       # removes 0
\ print $stack->top; # prints -1
\ $stack->push(0);
\ print $stack->min; # prints -1

100 CONSTANT stack_size
CREATE stack stack_size CELLS ALLOT     \ create stack
VARIABLE stack_ptr
-1 stack_ptr !                          \ init empty stack

: stack.top-addr    ( -- addr )
    stack stack_ptr @ CELLS +
;

: stack.push ( n -- )
    1 stack_ptr +!              \ increment stack pointer
    stack.top-addr !
;

: stack.pop ( -- )
    -1 stack_ptr +!             \ decrement stack pointer
;

: stack.top ( -- n )
    stack.top-addr @            \ return data at top of stack
;

: stack.min ( -- n )
    stack @                     \ init minimum
    stack_ptr @ 1+ 0 ?DO
        stack I CELLS + @
        MIN
    LOOP
;

\ example
                    \ my $stack = Stack->new;
2  stack.push       \ $stack->push(2);
-1 stack.push       \ $stack->push(-1);
0  stack.push       \ $stack->push(0);
stack.pop           \ $stack->pop;       # removes 0
stack.top . CR      \ print $stack->top; # prints -1
0  stack.push       \ $stack->push(0);
stack.min . CR      \ print $stack->top; # prints -1
BYE
