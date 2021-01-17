use strict;
use warnings;
##
# Write a script to demonstrate Stack operations.
##
use Stack;

my $stack = new Stack();
$stack->push(2);
$stack->push(-1);
$stack->push(0);
$stack->pop;       
print $stack->top . "\n"; 
$stack->push(0);
print $stack->min . "\n"; 