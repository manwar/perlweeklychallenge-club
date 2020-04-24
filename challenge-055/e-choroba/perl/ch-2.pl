#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my %solutions;
sub waves {
    %solutions = ();
    _waves([], @_);
    return [ map [split], keys %solutions ]
}

sub _waves {
    my ($so_far, @arr) = @_;
    unless (@arr) {
        undef $solutions{"@$so_far"};
        return
    }

    if (1 == @arr && (!@$so_far || $arr[0] >= $so_far->[-1])) {
        undef $solutions{"@$so_far $arr[0]"};
        return
    }

    for my $i (0 .. $#arr - 1) {
        for my $j ($i + 1 .. $#arr) {
            my @pair = $arr[$i] < $arr[$j] ? @arr[$j, $i] : @arr[$i, $j];
            next if @$so_far && $so_far->[-1] > $pair[0];

            _waves([ @$so_far, @pair ], @arr[
                grep $_ != $i && $_ != $j, 0 .. $#arr
            ]);
        }
    }
}

use Test::More;
use Test::Deep;

cmp_deeply waves(), [[]];
cmp_deeply waves(1), [[1]];

cmp_deeply waves(1, 2), [ [2, 1] ];
cmp_deeply waves(1, 1), [ [1, 1] ];

cmp_deeply waves(1, 2, 3), bag([2, 1, 3], [3, 1, 2]);
cmp_deeply waves(1, 1, 2), bag([2, 1, 1], [1, 1, 2]);
cmp_deeply waves(1, 2, 2), [[2, 1, 2]];
cmp_deeply waves(1, 1, 1), [[1, 1, 1]];

cmp_deeply waves(1 .. 4), bag([2, 1, 4, 3], [3, 1, 4, 2], [3, 2, 4, 1],
                              [4, 1, 3, 2], [4, 2, 3, 1]);

cmp_deeply waves(1, 1, 1, 1), [[1, 1, 1, 1]];
cmp_deeply waves(1, 1, 2, 2), bag([2, 1, 2, 1], [1, 1, 2, 2]);
cmp_deeply waves(1, 1, 1, 2), bag([2, 1, 1, 1], [1, 1, 2, 1]);
cmp_deeply waves(2, 2, 2, 1), bag([2, 2, 2, 1], [2, 1, 2, 2]);
cmp_deeply waves(1, 1, 2, 3), bag([3, 1, 2, 1], [2, 1, 3, 1], [1, 1, 3, 2]);
cmp_deeply waves(1, 2, 3, 3), bag([3, 1, 3, 2], [3, 2, 3, 1], [2, 1, 3, 3]);
cmp_deeply waves(1, 2, 2, 3), bag([3, 2, 2, 1], [2, 2, 3, 1], [2, 1, 3, 2],
                                  [3, 1, 2, 2]);

done_testing();
