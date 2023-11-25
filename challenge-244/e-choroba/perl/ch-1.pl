#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

# First, for each integer remember all the indices where it appears. Then, loop
# over the sorted integers. We know that the first integer has 0 smaller
# numbers, so just fill zeros to all the indices remembered for it. For each
# other integer the number of integers smaller than it equals the count of all
# the previous integers, so we can accumulate it in a variable and just add the
# number of stored indices in each step.
sub count_smaller_optimised(@ints) {
    my %where;
    push @{ $where{ $ints[$_] } }, $_ for 0 .. $#ints;
    my @result;
    my $count = 0;
    for my $s (@where{ sort { $a <=> $b } keys %where }) {
        @result[@$s] = ($count) x @$s;
        $count += @$s;
    }
    return \@result
}

sub count_smaller_naive(@ints) {
    [ map { my $x = $_; scalar grep $_ < $x, @ints } @ints ]
}

use Test2::V0;
plan 3 * 2 + 1;

is count_smaller_naive(8, 1, 2, 2, 3), [4, 0, 1, 1, 3], 'Example 1';
is count_smaller_naive(6, 5, 4, 8), [2, 1, 0, 3], 'Example 2';
is count_smaller_naive(2, 2, 2), [0, 0, 0], 'Example 3';

is count_smaller_optimised(8, 1, 2, 2, 3), [4, 0, 1, 1, 3], 'Example 1';
is count_smaller_optimised(6, 5, 4, 8), [2, 1, 0, 3], 'Example 2';
is count_smaller_optimised(2, 2, 2), [0, 0, 0], 'Example 3';

my @l = map int rand 100, 1 .. 100;
is count_smaller_naive(@l), count_smaller_optimised(@l), 'same';

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    naive       => sub { count_smaller_naive(@l) },
    optimised   => sub { count_smaller_optimised(@l) },
});

__END__
             Rate     naive optimised
naive      3710/s        --      -82%
optimised 20629/s      456%        --
