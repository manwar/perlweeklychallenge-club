#!/usr/bin/env perl
#
=head1 Task 2: Prime Count

Submitted by: Mohammad S Anwar

You are given an integer $n > 0.

Write a script to print the count of primes less than $n.

=head2 Example 1

    Input: $n = 10
    Output: 4 as in there are 4 primes less than 10 are 2, 3, 5 ,7.

=head2 Example 2

    Input: $n = 15
    Output: 6

=head2 Example 3

    Input: $n = 1
    Output: 0

=head2 Example 4

    Input: $n = 25
    Output: 9

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [10, 4, 'Example 1'],
    [15, 6, 'Example 2'],
    [ 1, 0, 'Example 3'],
    [25, 9, 'Example 4'],
];

# https://rosettacode.org/wiki/Sieve_of_Eratosthenes#Perl
sub gen_prime {
    my $p = shift;
    return $p, $p**2 > $_[$#_] ? @_ : gen_prime(grep $_ % $p, @_)
}

sub prime_count
{
    my $n = shift;

    my @p = gen_prime 2 .. $n if $n > 2;

    return scalar @p;
}

for (@$cases) {
    is(prime_count($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
