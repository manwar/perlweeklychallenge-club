#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#

#
# We will use a simple recursive function.
# The function takes three arguments:
#    - The target number we like to sum to ($target)
#    - The smallest Fibonnaci number we have not tried yet ($this_fib)
#    - The Fibonacci number proceeding the one above. ($prev_fib)
#
# If $this_fib is larger than $target, we have to way to make the target
# number, so we return 0. 
# If $this_fib is equal to $target, we can only make the target in one way,
# so we return 1.
# Else, we recurse. First, we count the number of ways to make
# $target - $this_fib with Fibonnaci numbers larger than $this_fib, then
# we count the number of ways making $target with Fibonnaci numbers larger
# than $this_fib. We return the sum of these counts.
#

sub count;
sub count ($target, $this_fib = 1, $prev_fib = 1) {
      $this_fib >  $target ? 0
    : $this_fib == $target ? 1
    : count ($target - $this_fib, $this_fib + $prev_fib, $this_fib) +
      count ($target,             $this_fib + $prev_fib, $this_fib)
}


say count $_ while <>;
