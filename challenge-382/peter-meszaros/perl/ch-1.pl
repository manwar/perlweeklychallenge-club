#!/usr/bin/env perl
#
=head1 Task 1: Hamiltonian Cycle

Submitted by: Peter Campbell Smith

You are given a target number.  Write a script to arrange all the whole numbers
from 1 up to the given target number into a circle so that every pair of
side-by-side numbers adds up to a perfect square. Please make sure, the last
number and the first must also add up to a square.

=head2 Example 1

    Input: $n = 32
    Output: 1, 8, 28, 21, 4, 32, 17, 19, 30, 6, 3, 13, 12, 24, 25, 11, 5,
            31, 18, 7, 29, 20, 16, 9, 27, 22, 14, 2, 23, 26, 10, 15

    1  + 8  = 9
    8  + 28 = 36
    28 + 21 = 49
    21 + 4  = 25
    4  + 32 = 36
    32 + 17 = 49
    17 + 19 = 36
    19 + 30 = 49

    so on, all the way through the sequence.

=head2 Example 2

    Input: $n = 15
    Output: ()

    No valid circular list of numbers exists.

=head2 Example 3

    Input: $n = 34
    Output: 1, 8, 28, 21, 4, 32, 17, 19, 6, 30, 34, 15, 10, 26, 23, 2, 14,
            22, 27, 9, 16, 33, 31, 18, 7, 29, 20, 5, 11, 25, 24, 12, 13, 3

    [2026-07-13 11:45]: Output was incorrect, corrected by E. Choroba.
=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };
use List::Util qw(any);

my @cases = (
    {n   => 32,
    out  => [1, 8, 28, 21, 4, 32, 17, 19, 30, 6, 3, 13, 12, 24, 25, 11, 5,
             31, 18, 7, 29, 20, 16, 9, 27, 22, 14, 2, 23, 26, 10, 15],
    name => 'Example 1'},
    {n   => 15,
    out  => [],
    name => 'Example 2'},
    {n   => 34,
    out =>  [1, 8, 28, 21, 15, 10, 26, 23, 13, 12, 24, 25, 11, 14, 2, 34, 30,
             6, 19, 17, 32, 4, 5, 20, 29, 7, 18, 31, 33, 16, 9, 27, 22, 3],
    name => 'Example 3'},
);

sub hamiltonian_cycle
{
    our $n = shift;
    my %sq = map { $_ * $_ => 1 } 2 .. int(sqrt(2 * $n)) + 1;

    our @g;
    for my $i (1..$n) {
        $g[$i] = [ grep { $_ != $i && $sq{$i + $_} } 1..$n ];
    }

    our @p = (1);
    our @used = (0) x ($n+1);
    $used[1] = 1;

    sub _dfs {
        my $v = $p[-1];

        return 1 if @p == $n && grep { $_ == 1 } @{$g[$v]};

        for my $u (
            sort { grep {!$used[$_]} @{$g[$a]} <=> grep {!$used[$_]} @{$g[$b]} }
            grep {!$used[$_]} @{$g[$v]}
        ) {
            $used[$u] = 1;
            push @p, $u;

            return 1 if _dfs();

            pop @p;
            $used[$u] = 0;
        }
        return 0;
    }

    return _dfs(), @p == 1 ? [] : \@p;
}

# multiple Hamiltionian cycles may exist, so we need to check if the returned path is valid
sub check_if_hamiltonian_cycle {
    my $path = shift;
    return 0 unless @$path;
    for my $i (0 .. @$path - 2) {
        my $n = sqrt($path->[$i] + $path->[$i+1]);
        return 0 unless $n == int($n);
    }
    return 1;
}

for my $case (@cases) {
    my ($s, $p) = hamiltonian_cycle($case->{n});
    is(check_if_hamiltonian_cycle($p), $s, $case->{name});
}
done_testing();

exit 0;

