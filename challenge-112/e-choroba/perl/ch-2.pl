#!/usr/bin/perl
use warnings;
use strict;

sub climb_stairs {
    my ($n) = @_;
    return 0 if 0 == $n;

    my @s = (1, 2);
    push @s, $s[1] + shift @s for 2 .. $n;
    return $s[0]
}

sub climb_stairs_options {
    my ($n) = @_;
    return [] if 0 == $n;

    my @s = ([[1]], [[1, 1], [2]]);
    push @s, [(map [1, @$_], @{ $s[1] }),
              (map [2, @$_], @{ shift @s })]
        for 2 .. $n;
    return $s[0]
}

use Test::More;
use Test::Deep;

is climb_stairs(0), 0;
is climb_stairs(1), 1;
is climb_stairs(2), 2;
is climb_stairs(3), 3;
is climb_stairs(4), 5;
is climb_stairs(5), 8;
is climb_stairs(6), 13;

#                   ^
#                   |
# Hmm, looks almost like the Fibonacci sequence!
# The difference is the element 0, it depends on whether we allow no
# steps as being a solution or not.

cmp_deeply climb_stairs_options(1), [[1]];
cmp_deeply climb_stairs_options(2), [[1, 1], [2]];
cmp_deeply climb_stairs_options(3), [[1, 1, 1], [1, 2], [2, 1]];
cmp_deeply climb_stairs_options(4), bag([1, 1, 1, 1],
                                        [1, 1, 2], [1, 2, 1], [2, 1, 1],
                                        [2, 2]);
cmp_deeply climb_stairs_options(5),
    bag([1, 1, 1, 1, 1],
        [1, 1, 1, 2], [1, 1, 2, 1], [1, 2, 1, 1], [2, 1, 1, 1],
        [1, 2, 2], [2, 1, 2], [2, 2, 1]);

done_testing();
