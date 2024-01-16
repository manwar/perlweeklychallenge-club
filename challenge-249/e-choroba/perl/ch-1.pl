#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub equal_pairs_count(@ints) {
    my %seen;
    ++$seen{$_} for @ints;
    return [map $seen{$_} % 2 ? return []
                              : ([$_, $_]) x ($seen{$_} / 2),
            keys %seen]
}

sub equal_pairs_odd(@ints) {
    my %odd;
    my @pairs;
    for my $i (@ints) {
        if (exists $odd{$i}) {
            delete $odd{$i};
            push @pairs, [$i, $i];
        } else {
            undef $odd{$i};
        }
    }
    return keys %odd ? [] : \@pairs
}


use Test2::V0 -srand => srand;
plan 2 + 1;

my $type = 'count';
*equal_pairs = *equal_pairs_count{CODE};
for (1, 2) {
    subtest $type => sub {
        plan 5;

        is equal_pairs(3, 2, 3, 2, 2, 2),
            bag { item $_ for [2, 2], [2, 2], [3, 3]; },
            'Example 1';

        is equal_pairs(1, 2, 3, 4), [], 'Example 2';


        is equal_pairs(-1, -1, -2, -2),
            bag { item $_ for [-1, -1], [-2, -2]; },
            'Negative numbers';

        is equal_pairs(1, 1, 1, 1, 2, 2, 2, 2),
            bag { item $_ for [1, 1], [1, 1], [2, 2], [2, 2]; },
            'More than once';

        is equal_pairs(1, 1, 1, 1, 2, 2, 2, 2, 1),
            [],
            'More than once odd';
    };

    no warnings 'redefine';
    $type = 'odd';
    *equal_pairs = *equal_pairs_odd{CODE};
}

use Benchmark qw{ cmpthese };

my @l = map int rand 1000, 1 .. 100_000;
is equal_pairs_odd(@l), equal_pairs_count(@l), 'same';
cmpthese(-3, {
    odd   => sub { equal_pairs_odd(@l) },
    count => sub { equal_pairs_count(@l) },
});

__END__
        Rate   odd count
odd   9.97/s    --  -82%
count 55.5/s  456%    --
