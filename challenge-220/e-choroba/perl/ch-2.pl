#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Math::Combinatorics;

sub squareful(@ints) {
    my %results;
    my @r = wrap([$ints[0]], @ints[1 .. $#ints]);
    @results{map "@$_", @r} = ();
    return [map [split], keys %results]
}

sub wrap($done, @rest) {
    return $done unless @rest;

    my %results;
    for my $i (0 .. $#rest) {
        for my $edge (0, -1) {
            my $sqrt = sqrt($rest[$i] + $done->[$edge]);
            next unless int($sqrt) == $sqrt;

            @results{ map "@$_",
                      wrap($edge ? [@$done, $rest[$i]] : [$rest[$i], @$done],
                           @rest[grep $_ != $i, 0 .. $#rest])
                    } = ();

        }
    }
    return map [split], keys %results
}

sub squareful_bruteforce(@ints) {
    my $permutator = 'Math::Combinatorics'->new(data => \@ints);
    my %results;
  PERMUTATION:
    while (my @permutation = $permutator->next_permutation) {
        for my $i (1 .. $#permutation) {
            my $sqrt = sqrt($permutation[$i] + $permutation[ $i - 1 ]);
            next PERMUTATION unless int($sqrt) == $sqrt;
        }
        undef $results{"@permutation"};
    }
    return [map [split], keys %results]
}

use Test2::V0;
plan 9;

for my $s (*squareful{CODE}, *squareful_bruteforce{CODE}) {
    is $s->(1, 17, 8), bag { item $_ for [1, 8, 17], [17, 8, 1] }, 'Example 1';
    is $s->(2, 2, 2), [[2, 2, 2]], 'Example 2';

    is $s->(1, 2, 3, 4, 5), [], 'Empty';
    is $s->(3, 6, 3, 6, 30, 19), bag { item $_ for [3, 6, 3, 6, 30, 19],
                                                   [19, 30, 6, 3, 6, 3],
                                                   [30, 19, 6, 3, 6, 3],
                                                   [3, 6, 3, 6, 19, 30],
                                                   [3, 6, 30, 19, 6, 3],
                                                   [3, 6, 19, 30, 6, 3];
                                       end},
        'Longer';
}

use Benchmark qw{ cmpthese };
my @l = (1, 3, 9, 0, 16, 9, 27, 22, 14, 11);
is squareful(@l), bag { item $_ for @{ squareful_bruteforce(@l) } }, 'same';

cmpthese(-60, {
    bruteforce => sub { squareful_bruteforce(@l) },
    optimised  => sub { squareful(@l) },
});

__END__
             s/iter bruteforce  optimised
bruteforce     19.2         --      -100%
optimised  3.30e-02     58110%         --
