#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given $n steps to climb

Write a script to find out the distinct ways to climb to the top. You are allowed to climb either 1 or 2 steps at a time.
Example

Input: $n = 3
Output: 3

    Option 1: 1 step + 1 step + 1 step
    Option 2: 1 step + 2 steps
    Option 3: 2 steps + 1 step

Input: $n = 4
Output: 5

    Option 1: 1 step + 1 step + 1 step + 1 step
    Option 2: 1 step + 1 step + 2 steps
    Option 3: 2 steps + 1 step + 1 step
    Option 4: 1 step + 2 steps + 1 step
    Option 5: 2 steps + 2 steps

=cut


use List::Util qw(sum);
my $n = shift or die "Number of steps to climb?$/";
my $opt = 1;
for my $m ( $n/2 .. $n )
{
     my @steps = 
          grep { sum(@$_) == $n }
          map { [split(//,$_)] }
          glob q[{1,2}] x $m;


     for my $step ( @steps )
     {
          @$step = map {$_ == 1 ? $_ . ' step' : $_ . ' steps'} @$step;

          print "Option ${opt}: ", join(' + ', @$step), $/;
          $opt++;
     }
}