use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 095
=========================

Task #2
-------
*Demo Stack*

Submitted by: Mohammad S Anwar (http://www.manwar.org)

Write a script to demonstrate Stack operations like below:

push($n) - add $n to the stack

pop() - remove the top element

top() - get the top element

min() - return the minimum element

Example:

 my $stack = Stack->new;
 $stack->push(2);
 $stack->push(-1);
 $stack->push(0);
 $stack->pop;       # removes 0
 print $stack->top; # prints -1
 $stack->push(0);
 print $stack->min  # prints -1

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

use lib < . >;
use Stack;

#==============================================================================
=begin comment

The Stack implementation uses a Raku array as its underlying data structure.

From the Task Example, and given that the required stack has a min() method
which returns "the minimum element," it appears that the stack is intended to
hold numeric values only. For this purpose, stack elements are typed as Real.

Calling pop(), top(), or min() on an empty stack is an error. What is the best
way to handle an error of this kind? Two strategies are possible:

(1) Return an undefined value (in this case, the Real type object itself,
    equivalent to Nil). This allows the erroneous call to fail silently.
(2) Throw a suitable exception.

This implementation allows the user to specify the desired strategy upon Stack
creation, via the boolean attribute "throw": a False value selects strategy
(1), a True value selects strategy (2). If neither strategy is specified, (2)
is the default.

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 095, Task #2: Demo Stack (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    # Change to "throw => True" to demonstrate the Stack::Empty exception
    # mechanism

    my Stack $stack = Stack.new( throw => False );
    "New stack:\n%s\n"\                 .printf:        $stack.display;

    $stack.push( 2 );
    "push(2):\n%s\n"\                   .printf:        $stack.display;

    $stack.push( -1 );
    "push(-1):\n%s\n"\                  .printf:        $stack.display;

    $stack.push( 0 );
    "push(0):\n%s\n"\                   .printf:        $stack.display;

    my Real $item = $stack.pop;
    "pop(): The popped item is %s\n%s\n".printf: $item, $stack.display;

    $item = $stack.top;
    "top(): The top item is %s\n%s\n"\  .printf: $item, $stack.display;

    $stack.push( 0 );
    "push(0):\n%s\n"\                   .printf:        $stack.display;

    $item = $stack.min;
    "min(): The min item is %s\n%s\n"\  .printf: $item, $stack.display;

    $item = $stack.pop;
    "pop(): The popped item is %s\n%s\n".printf: $item, $stack.display;

    $item = $stack.pop;
    "pop(): The popped item is %s\n%s\n".printf: $item, $stack.display;

    $item = $stack.pop;
    "pop(): The popped item is %s\n%s\n".printf: $item, $stack.display;

    $item = $stack.top;
    "top(): The top item is %s\n%s\n"\  .printf:
                    $item.defined ?? $item !! '(none)', $stack.display;

    $stack.push( 123.4 );
    "push(123.4):\n%s"\                 .printf:        $stack.display;

    CATCH
    {
        when Stack::Empty { $*ERR.printf: "%s\n", .message; }
    }
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
