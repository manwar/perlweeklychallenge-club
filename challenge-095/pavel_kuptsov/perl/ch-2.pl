#!/usr/bin/perl -w

use strict;
use warnings;
use feature qw(say);
use List::Util qw();
use Test::More;

=head2
TASK #2 › Demo Stack
Submitted by: Mohammad S Anwar
Write a script to demonstrate Stack operations like below:

push($n) - add $n to the stack
pop() - remove the top element
top() - get the top element
min() - return the minimum element

my $stack = Stack->new;
$stack->push(2);
$stack->push(-1);
$stack->push(0);
$stack->pop;       # removes 0
print $stack->top; # prints -1
$stack->push(0);
print $stack->min; # prints -1

=cut


my @stack = ();

=head2 push($N)

push($n) - add $n to the stack

=cut
sub push
{
  CORE::push @stack, $_[0];
}


=head2 pop($N)

pop() - remove the top element

=cut
sub pop
{
  return CORE::pop @stack;
}


=head2 top($N)

top() - get the top element

=cut
sub top
{
  return $stack[-1];
}


=head2 min($N)

min() - return the minimum element

=cut
sub min
{
  return List::Util::min @stack;
}

main::push 10;
main::push -1;
main::push 0;

ok( scalar @stack == 3 );

main::pop;

ok( scalar @stack == 2 );
ok( $stack[-1] == -1 );
ok( main::top == -1 );

main::push 0;

ok( main::min == -1 );


done_testing(5);