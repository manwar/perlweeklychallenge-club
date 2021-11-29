#!/usr/bin/perl

use strict;
use warnings;

=head1

Week 140:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-140

Task #2: Multiplication Table

    You are given 3 positive integers, $i, $j and $k.

    Write a script to print the $kth element in the sorted multiplication table of $i and $j.

=cut

use Test::More;

is( multiplication_table(2, 3, 4), 3, 'Example 1' );
is( multiplication_table(3, 3, 6), 4, 'Example 2' );

done_testing;

sub multiplication_table {
    my ($i, $j, $k) = @_;

    die "ERROR: Missing '$i'\n." unless defined $i;
    die "ERROR: Missing '$j'\n." unless defined $j;
    die "ERROR: Missing '$k'\n." unless defined $k;

    die "ERROR: Invalid '$i' [$i]\n." if ($i < 0);
    die "ERROR: Invalid '$j' [$j]\n." if ($j < 0);
    die "ERROR: Invalid '$k' [$k]\n." if ($k < 0);

    my $table  = [];
    foreach my $_i (1 .. $i) {
        foreach my $_j (1 .. $j) {
            push @$table, $_i * $_j;
        }
    }

    return (sort @$table)[$k-1];
}
