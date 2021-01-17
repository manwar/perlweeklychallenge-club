=begin comment
Perl Weekly Challenge 
https://perlweeklychallenge.org/blog/perl-weekly-challenge-095/

095-2 Demo Stack

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
print $stack->min; # prints -1

=end comment

class Stack {
  has @.stack;

  method push( $n ) { @.stack.push: $n   }
  method pop()      { @!stack.pop }
  method top()      { @!stack[@!stack.elems -1] }
  method min()      { @!stack.min }
}

multi sub MAIN( 'challenge' ) {
  my $stack = Stack.new;
  $stack.push(2);
  $stack.push(-1);
  $stack.push(0);
  $stack.pop;
  $stack.top.say;
  $stack.push(0);
  $stack.min.say;
}

multi sub MAIN( 'test' ) {
  use Test;

  my $stack = Stack.new;
  $stack.push(2);
  $stack.push(-1);
  $stack.push(0);
  $stack.pop; 
  is($stack.top, -1);
  $stack.push(0);
  is($stack.min, -1);
}
