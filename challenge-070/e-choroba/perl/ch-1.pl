#!/usr/bin/perl
use warnings;
use strict;

# Without Pete's additional constraint.
sub swap {
    my ($string, $count, $offset) = @_;
    my $length = length $string;
    for my $i (1 .. $count) {
        substr $string, $i % $length, 1,
            substr $string, ($i + $offset) % $length, 1,
            substr $string, $i % $length, 1;
    }
    return $string
}

# We add Pete's additional constraint, but we also need
#   $count + $offset < $length.
# Then we can do all the swaps in one step.
sub swap_constrained {
    my ($string, $count, $offset) = @_;
    my $length = length $string;

    # die unless $count >= 1
    #     && $offset >= 1
    #     && $count <= $offset
    #     && $count + $offset < $length;

    my $r = substr($string, 0, 1)
              . substr($string, $offset + 1, $count)
              . substr($string, $count + 1, $offset - $count)
              . substr($string, 1, $count)
              . substr($string, $offset + $count + 1);

    return substr $r, 0, $length
}


use Test::More tests => 218;
is swap('perlandraku', 1, 4), 'pnrlaedraku';
is swap('perlandraku', 2, 4), 'pndlaerraku';
is swap('perlandraku', 3, 4), 'pndraerlaku';

is swap('abcd', 1, 1), 'acbd';
is swap('abcd', 2, 1), 'acdb';  # What's wrong with that, Pete?
is swap('abcd', 3, 1), 'bcda';
is swap('abcd', 4, 1), 'cbda';
is swap('abcd', 5, 1), 'cdba';
is swap('abcd', 6, 1), 'cdab';
is swap('abcd', 7, 1), 'bdac';
is swap('abcd', 8, 1), 'dbac';
is swap('abcd', 9, 1), 'dabc';
is swap('abcd', 10, 1), 'dacb';
is swap('abcd', 11, 1), 'bacd';
is swap('abcd', 12, 1), 'abcd';

for my $in (qw( abc abcd abcde abcdef abcdefg abcdefgh perlandraku
                abcdefghijklmopqrstuvwxyz
)) {
    for my $count (1 .. + length($in) - 2) {
        for my $offset ($count .. length($in) - $count - 1) {
            is swap_constrained($in, $count, $offset),
                swap($in, $count, $offset),
               "$in-$count-$offset";
        }
    }
}

use Benchmark qw{ cmpthese };
cmpthese(-2, {
    slow => sub { swap('perlweeklychallenge', 5, 10) },
    fast => sub { swap_constrained('perlweeklychallenge', 5, 10) },
});

#           Rate slow fast
# slow  504119/s   -- -54%
# fast 1102688/s 119%   --
