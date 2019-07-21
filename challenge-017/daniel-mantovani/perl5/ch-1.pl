# Create a script to demonstrate Ackermann function.
# The Ackermann function is defined as below, m and n are positive number:

#   A(m, n) = n + 1                  if m = 0
#   A(m, n) = A(m - 1, 1)            if m > 0 and n = 0
#   A(m, n) = A(m - 1, A(m, n - 1))  if m > 0 and n > 0
# Example expansions as shown in wiki page.

#  A(1, 2) = A(0, A(1, 1))
#          = A(0, A(0, A(1, 0)))
#          = A(0, A(0, A(0, 1)))
#          = A(0, A(0, 2))
#          = A(0, 3)
#          = 4

use strict;
use warnings;
use v5.10;

# pretty straightforward, we can just translate definitions to a (recursive)
# perl function:

# sub A {
#     my ( $m, $n ) = @_;
#     if ( $m == 0 ) { return $n + 1 }
#     elsif ( $m > 0 && $n == 0 ) { return A( $m - 1, 1 ) }
#     elsif ( $m > 0 && $n > 0 ) { return A( $m - 1, A( $m, $n - 1 ) ) }
#     else {
#         die "m ($m) and n ($n) are not a valid input for Ackermann function";
#     }
# }

# if we assume m and n are valid values, you can optimize a bit like this:

sub A {
    my ( $m, $n ) = @_;
    return $n + 1 unless $m;
    return A( $m - 1, 1 ) unless $n;
    return A( $m - 1, A( $m, $n - 1 ) );
}

my ( $m, $n ) = @ARGV;

die "Usage: perl $0 <m> <n>\nwith <n> and <n> 0 or positive integers"
  unless defined $m
  && $m =~ /^\d+$/
  && defined $n
  && $n =~ /^\d+$/;

say A( $m, $n );

# note that Ackermann function is higly recursive, and even for small m & n numbers
# will make perl default configuration for recursive functions fail
# for example, A(3,4) is known to be 125 (2 ^ 7 - 3), and in my
# computer it gives a "Deep recursion" warning, despite getting the
# correct (125) value at the end.
#
# This proposed solution is valid to answer corresponding perl weekly's challenge only
