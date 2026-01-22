#!/usr/bin/env perl
#
=head1 Task 2: Unique Fraction Generator

Submitted by: Yary

Given a positive integer N, generate all unique fractions you can create using
integers from 1 to N and follow the rules below:

    - Use numbers 1 through N only (no zero)
    - Create fractions like numerator/denominator
    - List them in ascending order (from smallest to largest)
    - If two fractions have the same value (like 1/2 and 2/4),
      only show the one with the smallest numerator

=head2 Example 1

    Input: $int = 3
    Output: 1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1

=head2 Example 2

    Input: $int = 4
    Output: 1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1

=head2 Example 3

    Input: $int = 1
    Output: 1/1

=head2 Example 4

    Input: $int = 6
    Output: 1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4,
        4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1,
        5/2, 3/1, 4/1, 5/1, 6/1

=head2 Example 5

    Input: $int = 5
    Output: 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1,
        5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [3, [qw{1/3 1/2 2/3 1/1 3/2 2/1 3/1}],      'Example 1'],
    [4, [qw{1/4 1/3 1/2 2/3 3/4 1/1 4/3 3/2 2/1
            3/1 4/1}],                          'Example 2'],
    [1, [qw{1/1}],                              'Example 3'],
    [6, [qw{1/6 1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4
            4/5 5/6 1/1 6/5 5/4 4/3 3/2 5/3 2/1
            5/2 3/1 4/1 5/1 6/1}],              'Example 4'],
    [5, [qw{1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5
            1/1 5/4 4/3 3/2 5/3 2/1 5/2 3/1 4/1
            5/1}],                              'Example 5'],
];

sub unique_fraction_generator
{
    my $n = shift;
    my %seen;
    my @fractions;

    for my $denom (1 .. $n) {
        for my $num (1 .. $n) {
            my $value = $num / $denom;
            unless (exists $seen{$value}) {
                push @fractions, [$value, "$num/$denom"];
                $seen{$value} = true;
            }
        }
    }

    @fractions = sort { $a->[0] <=> $b->[0] } @fractions;
    return [map { $_->[1] } @fractions];
}

for (@$cases) {
    is(unique_fraction_generator($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
