#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
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

=cut



package MyStack
{
     use strict;
     use warnings FATAL => qw(all);

     sub new
     {
          my ($class,@data) = @_;
          bless [@data], $class;
     }





     sub push { push @{$_[0]}, $_[1] }
     sub pop {  pop @{$_[0]} }

     sub top { return ${$_[0]}[-1] }
     sub min 
     { 
          my $min = ${$_[0]}[0];

          for (@{$_[0]})
          {
               $min = $_ if $_ < $min;
          }
          return $min;
     }
     sub empty { @{$_[0]} = () }
     sub size { return scalar @{$_[0]} }

     sub print_me { print join("", "<<'", join("' '", @{$_[0]}), "'<<"), $/; }
     1;
}



my $stack = MyStack->new;


$stack->push(2);
$stack->push(-1);
$stack->push(0);

$stack->print_me;

$stack->pop; # removes 0
$stack->print_me; 


print "Top: ", $stack->top, $/; # prints -1


$stack->push(0);
print "Min: ", $stack->min, $/; # prints -1
$stack->print_me;


print "Size: ", $stack->size, $/;
$stack->empty;
print "Size: ", $stack->size, $/;

$stack->push(2);
$stack->push(-1);
$stack->push(0);


$stack->print_me;