#!/usr/bin/env perl
#
=head1 Task 1: Kaprekar Constant

Submitted by: Mohammad Sajid Anwar

Write a function that takes a 4-digit integer and returns how many iterations
are required to reach Kaprekar's constant (6174). For more information about
Kaprekar's Constant please follow the wikipedia page.

=head2 Example 1

    Input: $int = 3524
    Output: 3

    Iteration 1: 5432 - 2345 = 3087
    Iteration 2: 8730 - 0378 = 8352
    Iteration 3: 8532 - 2358 = 6174

=head2 Example 2

    Input: $int = 6174
    Output: 0

=head2 Example 3

    Input: $int = 9998
    Output: 5

    Iteration 1: 9998 - 8999 = 0999
    Iteration 2: 9990 - 0999 = 8991
    Iteration 3: 9981 - 1899 = 8082
    Iteration 4: 8820 - 0288 = 8532
    Iteration 5: 8532 - 2358 = 6174

=head2 Example 4

    Input: $int = 1001
    Output: 4

    Iteration 1: 1100 - 0011 = 1089
    Iteration 2: 9810 - 0189 = 9621
    Iteration 3: 9621 - 1269 = 8352
    Iteration 4: 8532 - 2358 = 6174

=head2 Example 5

    Input: $int = 9000
    Output: 4

    Iteration 1: 9000 - 0009 = 8991
    Iteration 2: 9981 - 1899 = 8082
    Iteration 3: 8820 - 0288 = 8532
    Iteration 4: 8532 - 2358 = 6174

=head2 Example 6

    Input: $int = 1111
    Output: -1

    The sequence does not converge on 6174, so return -1.

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [3524,  3, 'Example 1'],
    [6174,  0, 'Example 2'],
    [9998,  5, 'Example 3'],
    [1001,  4, 'Example 4'],
    [9000,  4, 'Example 5'],
    [1111, -1, 'Example 6'],
];

sub kaprekar_constant
{
    my $n = shift;
    return -1 if $n =~ /^(\d)\1{3}$/;

    my $KAPREKAR = 6174;
    my $iter = 0;

    while ($n != $KAPREKAR) {
        my @digits = split //, sprintf("%04d", $n);
        my $asc  = join '', sort { $a <=> $b } @digits;
        my $desc = join '', sort { $b <=> $a } @digits;
        $n = $desc - $asc;
        $iter++;
    }

    return $iter;
}

for (@$cases) {
    is(kaprekar_constant($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
