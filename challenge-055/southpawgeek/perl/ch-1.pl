#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my $B = "010";
my @LR =(
    {'L' => 0, 'R' => 0},
    {'L' => 0, 'R' => 1},
    {'L' => 0, 'R' => 2},
    {'L' => 1, 'R' => 1},
    {'L' => 1, 'R' => 2},
    {'L' => 2, 'R' => 2});

flip($B, $_) foreach @LR;

my $pos;
my @max1s;

sub flip {
    my ($B, $LR) = @_;
    my @N = unpack '(A)*', $B;
    my $L = $LR->{'L'};
    my $R = $LR->{'R'};

    say "L=$L, R=$R";

    for ($L..$R) {
        $N[$L] = 1 - $N[$L];
        $L++;
    }

    say "$B -> ", @N;
    say "-"x15;

    my $x = ("@N" =~ tr/1/1/);
    push @{$max1s[$x]}, $LR;
    $pos = $x if $x > $pos;
}

say "max total positive bits: $pos";
say "sets resulting in $pos positive bits";

my $max = pop @max1s;
say "L=", $_->{'L'}, " R=", $_->{'R'} foreach @$max;