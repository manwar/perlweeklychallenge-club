#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use enum qw( NUMBER POINTS );
use List::Util qw{ shuffle sum };

my $DICT = '/usr/share/dict/british';

my %tile = (
    A => [ 8,  1 ], G => [ 3,  1 ], I => [ 5, 1 ], S => [ 7, 1 ],
    U => [ 5,  1 ], X => [ 2,  1 ], Z => [ 5, 1 ], E => [ 9, 2 ],
    J => [ 3,  2 ], L => [ 3,  2 ], R => [ 3, 2 ], V => [ 3, 2 ],
    Y => [ 5,  2 ], F => [ 3,  3 ], D => [ 3, 3 ], P => [ 5, 3 ],
    W => [ 5,  3 ], B => [ 5,  4 ], N => [ 4, 4 ], T => [ 5, 5 ],
    O => [ 3,  5 ], H => [ 3,  5 ], M => [ 4, 5 ], C => [ 4, 5 ],
    K => [ 2, 10 ], Q => [ 2, 10 ]);

my @all = shuffle(map +($_) x $tile{$_}[NUMBER], keys %tile);

my %draw;
++$draw{$_} for @all[0 .. 6];
say "Drawn: @all[0 .. 6]";

open my $in, '<', $DICT or die $!;
my @max = (0, "");
WORD: while (<$in>) {
    chomp;

    my @chars = split //, uc;
    my %seen;
    $draw{$_} && $draw{$_} >= ++$seen{$_}
        or next WORD
        for @chars;

    my $score = sum(map $tile{$_}[POINTS], @chars);
    @max = ($score) if $score >  $max[0];
    push @max, $_   if $score >= $max[0];
}
say "@max";
