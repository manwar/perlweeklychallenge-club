#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ sum };

sub flip_binary {
    my ($binary) = @_;
    my @digits = split //, $binary;
    my @max = (0);
    for my $from (0 .. $#digits) {
        for my $to ($from .. $#digits) {
            my $sum = sum(map !$_, @digits[$from .. $to]);
            $sum += sum(@digits[0 .. $from - 1]) if $from > 0;
            $sum += sum(@digits[$to + 1 .. $#digits]) if $to < $#digits;

            ( sub { push @max, [$from, $to] },
              sub { @max = ($sum, [$from, $to]) },
              sub {}
            )[ $sum <=> $max[0] ]->();
        }
    }
    return [ @max[ 1 .. $#max ] ]
}

use Test::More;

is_deeply flip_binary('1'), [ [0, 0] ];
is_deeply flip_binary('0'), [ [0, 0] ];

is_deeply flip_binary('00'), [ [0, 1] ];
is_deeply flip_binary('01'), [ [0, 0] ];
is_deeply flip_binary('10'), [ [1, 1] ];
is_deeply flip_binary('11'), [ [0, 0], [1, 1] ];

is_deeply flip_binary('010'), [ [0, 0], [0, 2], [2, 2] ];
is_deeply flip_binary('000'), [ [0, 2] ];
is_deeply flip_binary('111'), [ [ 0, 0], [1, 1], [2, 2] ];

is_deeply flip_binary('000111001101'), [ [0, 2] ];

is_deeply
    flip_binary('1110000011110000011111000000011100000111100000011110000'),
    [ [3, 46], [3, 54] ];

is_deeply flip_binary('0' x 100), [ [0, 99] ];
is_deeply flip_binary('1' x 100), [ map [$_, $_], 0 .. 99 ];

done_testing();
