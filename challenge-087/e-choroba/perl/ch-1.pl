#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ uniq };

sub longest_consecutive_sequence {
    my @N = sort { $a <=> $b } uniq(@_);

    # To simplify the code, the last number will never be part of the
    # sequence.
    push @N, $N[-1] + 2;

    my ($from, $to, @longest);
    for my $i (1 .. $#N) {
        my $is_sequence = $N[$i - 1] == $N[$i] - 1;
        if (defined $from) {
            if ($is_sequence) {
                $to = $N[$i];
            } else {
                [
                    sub { push @longest, [$from, $to] },
                    sub { @longest = [$from, $to] },
                    sub {}
                ]->[@longest
                    ? $to - $from <=> $longest[0][1] - $longest[0][0]
                    : 1
                ]();
                undef $from;
            }
        } elsif (defined(
            $from = $is_sequence ? $N[$i - 1] : undef
        )) {
            $to = $N[$i];
        }
    }

    return [0] unless @longest;

    return [ map [ $_->[0] .. $_->[1] ], @longest ];
}

use Test::More tests => 7;

is_deeply longest_consecutive_sequence(100, 4, 50, 3, 2),
    [[2, 3, 4]], 'Example 1';
is_deeply longest_consecutive_sequence(20, 30, 10, 40, 50),
    [0], 'Example 2';
is_deeply longest_consecutive_sequence(20, 19, 9, 11, 10),
    [[9, 10, 11]], 'Example 3';

is_deeply longest_consecutive_sequence(1, 2, 3, 4, 6, 7, 8, 9),
    [[1, 2, 3, 4], [6, 7, 8, 9]], 'More than one';
is_deeply longest_consecutive_sequence(1, 2, 3, 4, 6, 7, 8, 9, 10),
    [[6, 7, 8, 9, 10]], 'Has shorter';
is_deeply longest_consecutive_sequence(1, 3, 4, 7, 8),
    [[3, 4], [7, 8]], 'Length 2';
is_deeply longest_consecutive_sequence(-2, -2, -1, -1, 0, 0, 1, 3),
    [[-2, -1, 0, 1]], 'Duplicates';
