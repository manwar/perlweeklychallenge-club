#!/usr/bin/env perl

=pod
Task 2: Summations
Submitted by: Mohammad S Anwar

You are given a list of positive numbers, @n.

Write a script to find out the summations as described below.

Example 1

Input: @n = (1, 2, 3, 4, 5)
Output: 42

    1 2 3  4  5
      2 5  9 14
        5 14 28
          14 42
             42

The nth Row starts with the second element of the (n-1)th row.
The following element is sum of all elements except first element of previous row.
You stop once you have just one element in the row.

Example 2

Input: @n = (1, 3, 5, 7, 9)
Output: 70

    1 3  5  7  9
      3  8 15 24
         8 23 47
           23 70
              70

=cut

package challenge163::ch2;

use strict;
use warnings;
use autodie;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use FindBin    ();
use File::Spec ();

use List::Util qw(all sum0);

use lib File::Spec->catdir( $FindBin::RealBin,
    qw'.. .. .. challenge-001 alexander-pankoff perl lib' );

run() unless caller();

sub run() {
    my @n = @ARGV;

    # TODO: extract me
    die "Expect a list of if of positive intergers"
      unless all { $_ =~ m/^\d+$/ && $_ > 0 } @n;

    say summations(@n);

}

sub summations(@n) {
    return 0 if !@n;
    return $n[0] if @n == 1;

    my @next = ( scanl( sub ( $acc, $cur ) { $acc + $cur }, @n[ 1 .. $#n ] ) );

    return summations(@next);
}

# https://hackage.haskell.org/package/base-4.16.1.0/docs/Prelude.html#v:scanl
sub scanl ( $fn, $start, @xs ) {
    my $acc = $start;
    my @out = ($start);
    for my $x (@xs) {
        $acc = $fn->( $acc, $x );
        push @out, $acc;
    }

    return @out;
}
