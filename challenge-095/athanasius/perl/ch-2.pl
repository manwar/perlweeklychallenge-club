#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

The Stack implementation uses a Perl array as its underlying data structure.

From the Task Example, and given that the required stack has a min() method
which returns "the minimum element," it appears that the stack is intended to
hold numeric values only. For this purpose, only real numbers are allowed as
stack elements.

Calling pop(), top(), or min() on an empty stack is an error. What is the best
way to handle an error of this kind? Two strategies are possible:

(1) Return an undefined value: this allows the erroneous call to fail silently.
(2) Throw a suitable exception.

This implementation allows the user to specify the desired strategy upon Stack
creation, via the boolean attribute "throw": a false value selects strategy
(1), a true value selects strategy (2). If neither strategy is specified, (2)
is the default.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use lib qw( . );
use Stack;

const my $USAGE =>
"Usage:
  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 095, Task #2: Demo Stack (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    scalar @ARGV == 0 or die "ERROR: Too many command-line arguments\n$USAGE";

    # Change the argument to new() to a true value to demonstrate the exception
    # mechanism

    my $stack = Stack->new( 0 );
    printf "New stack:\n%s\n",                          $stack->display;

    $stack->push( 2 );
    printf "push(2):\n%s\n",                            $stack->display;

    $stack->push( -1 );
    printf "push(-1):\n%s\n",                           $stack->display;

    $stack->push( 0 );
    printf "push(0):\n%s\n",                            $stack->display;

    my $item = $stack->pop;
    printf "pop(): The popped item is %s\n%s\n", $item, $stack->display;

    $item = $stack->top;
    printf "top(): The top item is %s\n%s\n",    $item, $stack->display;

    $stack->push( 0 );
    printf "push(0):\n%s\n",                            $stack->display;

    $item = $stack->min;
    printf "min(): The min item is %s\n%s\n",    $item, $stack->display;

    $item = $stack->pop;
    printf "pop(): The popped item is %s\n%s\n", $item, $stack->display;

    $item = $stack->pop;
    printf "pop(): The popped item is %s\n%s\n", $item, $stack->display;

    $item = $stack->pop;
    printf "pop(): The popped item is %s\n%s\n", $item, $stack->display;

    $item = $stack->top;
    printf "top(): The top item is %s\n%s\n",
                      defined $item ? $item : '(none)', $stack->display;

    $stack->push( 123.4 );
    printf "push(123.4):\n%s",                          $stack->display;
}

###############################################################################
