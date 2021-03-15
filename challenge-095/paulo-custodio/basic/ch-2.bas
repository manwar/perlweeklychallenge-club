' Challenge 095
'
' TASK #2 › Demo Stack
' Submitted by: Mohammad S Anwar
' Write a script to demonstrate Stack operations like below:
'
' push($n) - add $n to the stack
' pop() - remove the top element
' top() - get the top element
' min() - return the minimum element
'
' Example:
' my $stack = Stack->new;
' $stack->push(2);
' $stack->push(-1);
' $stack->push(0);
' $stack->pop;       # removes 0
' print $stack->top; # prints -1
' $stack->push(0);
' print $stack->min; # prints -1

dim shared stack() as integer

sub push(n as integer)
    redim preserve stack(ubound(stack)+1)
    stack(ubound(stack)) = n
end sub

sub pop()
    redim preserve stack(ubound(stack)-1)
end sub

function top() as integer
    top = stack(ubound(stack))
end function

function min() as integer
    dim i as integer, m as integer
    m = stack(lbound(stack))
    for i=lbound(stack)+1 to ubound(stack)
        if stack(i) < m then m = stack(i)
    next i
    min = m
end function


                        ' my $stack = Stack->new;
push(2)                 ' $stack->push(2);
push(-1)                ' $stack->push(-1);
push(0)                 ' $stack->push(0);
pop()                   ' $stack->pop;       # removes 0
print trim(str(top()))  ' print $stack->top; # prints -1
push(0)                 ' $stack->push(0);
print trim(str(min()))  ' print $stack->min; # prints -1
