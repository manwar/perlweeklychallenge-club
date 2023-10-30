#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ product };

sub unequal_triplets(@ints) {
    my $count = 0;
    for my $i (0 .. $#ints - 2) {
        for my $j ($i + 1 .. $#ints - 1) {
            for my $k ($j + 1 .. $#ints) {
                ++$count if $ints[$i] != $ints[$j]
                         && $ints[$j] != $ints[$k]
                         && $ints[$k] != $ints[$i]
            }
        }
    }
    return $count
}

sub unequal_triplets_optimized(@ints) {
    my %seen;
    ++$seen{$_} for @ints;
    my @unique = keys %seen;
    my $count = 0;
    for my $i (0 .. $#unique - 2) {
        for my $j ($i + 1 .. $#unique - 1) {
            for my $k ($j + 1 .. $#unique) {
                $count += product(@seen{ @unique[$i, $j, $k] });
            }
        }
    }
    return $count
}

use Test::More tests => 3 + 3 + 2;

is unequal_triplets(4, 4, 2, 4, 3), 3, 'Example 1 naive';
is unequal_triplets(1, 1, 1, 1, 1), 0, 'Example 2 naive';
is unequal_triplets(4, 7, 1, 10, 7, 4, 1, 1), 28, 'Example 3 naive';

is unequal_triplets_optimized(4, 4, 2, 4, 3), 3, 'Example 1 optimized';
is unequal_triplets_optimized(1, 1, 1, 1, 1), 0, 'Example 2 optimized';
is unequal_triplets_optimized(4, 7, 1, 10, 7, 4, 1, 1), 28,
    'Example 3 optimized';

my @long = ((1) x 100, (2) x 30, (3) x 20, (4) x 10, 5);
is unequal_triplets(@long), 123100, 'Long naive';
is unequal_triplets_optimized(@long), 123100, 'Long optimized';

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    naive     => sub { unequal_triplets(@long) },
    optimized => sub { unequal_triplets_optimized(@long) },
});

__END__
             Rate     naive optimized
naive      13.1/s        --     -100%
optimized 28171/s   215647%        --
