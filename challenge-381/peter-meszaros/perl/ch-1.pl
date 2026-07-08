#!/usr/bin/env perl
#
=head1 Task 1: Same Row Column

Submitted by: Mohammad Sajid Anwar

You are given a n x n matrix containing integers from 1 to n.  Write a script
to find if every row and every column contains all the integers from 1 to n.

=head2 Example 1

    Input: @matrix = ([1, 2, 3, 4],
                      [2, 3, 4, 1],
                      [3, 4, 1, 2],
                      [4, 1, 2, 3],)
    Output: true

=head2 Example 2

    Input: @matrix = ([1])
    Output: true

=head2 Example 3

    Input: @matrix = ([1, 2, 5],
                      [5, 1, 2],
                      [2, 5, 1],)
    Output: false

    Elements are out of range 1..3.

=head2 Example 4

    Input: @matrix = ([1, 2, 3],
                      [1, 2, 3],
                      [1, 2, 3],)
    Output: false

=head2 Example 5

    Input: @matrix = ([1, 2, 3],
                      [3, 1, 2],
                      [3, 2, 1],)
    Output: false

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {matrix => [[1, 2, 3, 4],
                [2, 3, 4, 1],
                [3, 4, 1, 2],
                [4, 1, 2, 3],
               ], out => true, name => 'Example 1'},
    {matrix => [[1]
               ], out => true, name => 'Example 2'},
    {matrix => [[1, 2, 5],
                [5, 1, 2],
                [2, 5, 1],
               ], out => false, name => 'Example 3'},
    {matrix => [[1, 2, 3],
                [1, 2, 3],
                [1, 2, 3],
               ], out => false, name => 'Example 4'},
    {matrix => [[1, 2, 3],
                [3, 1, 2],
                [3, 2, 1],
               ], out => false, name => 'Example 5'},
);

sub same_row_column
{
    my $matrix = shift;

    my $n = @$matrix;

    for my $i (0 .. $n - 1) {
        my %col;
        my %row;
        for my $j (0 .. $n - 1) {
            my $colval = $matrix->[$i][$j];
            my $rowval = $matrix->[$j][$i];
            return false if $rowval < 1 || $rowval > $n ||
                            $colval < 1 || $colval > $n;
            $col{$colval}++;
            $row{$rowval}++;
        }
        return false if scalar keys %col != $n || scalar keys %row != $n;
    }
    return true;
}

for my $case (@cases) {
    my $got = same_row_column($case->{matrix});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
