#!/usr/bin/env perl

=pod
Task 1: Sum Bitwise Operator
Submitted by: Mohammad S Anwar

You are given list positive numbers, @n.

Write script to calculate the sum of bitwise & operator for all unique pairs.

Example 1

  Input: @n = (1, 2, 3)
  Output: 3
  
  Since (1 & 2) + (2 & 3) + (1 & 3) => 0 + 2 + 1 =>  3.

Example 2

  Input: @n = (2, 3, 4)
  Output: 2
  
  Since (2 & 3) + (2 & 4) + (3 & 4) => 2 + 0 + 0 =>  2.
=cut

package challenge163::ch1;

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
    die "Expect a list of if of positive intergers"
      unless all { $_ =~ m/^\d+$/ && $_ > 0 } @n;

    say sum_bitwise_operator(@n);
}

sub sum_bitwise_operator(@n) {
    sum0( map { $_->[0] & $_->[1] } unique_pairs(@n) );
}

sub unique_pairs(@xs) {
    return combinations( 2, @xs );
}

sub combinations ( $size, @xs ) {
    return if !@xs;
    return map { [$_] } @xs if $size == 1;

    my @out;
    for my $index ( 0 .. $#xs ) {
        my @rest = @xs[ $index + 1 .. $#xs ];
        for my $comb ( combinations( $size - 1, @rest ) ) {
            push @out, [ $xs[$index], @$comb ];
        }
    }

    return @out;
}
