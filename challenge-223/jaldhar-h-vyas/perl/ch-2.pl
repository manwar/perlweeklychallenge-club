#!/usr/bin/perl
use 5.030;
use warnings;

my @q;
push @q, { coins => 0, box => \@ARGV };
my $maxcoins = 0;

while (scalar @q) {
    my  %node = %{ shift @q };
    my $coins = $node{coins};
    my @box = @{ $node{box} };

    if (scalar @box == 0) {
        if ($coins > $maxcoins) {
            $maxcoins = $coins;
        }
        next;
    }

    for my $i (0 .. scalar @box - 1) {
        my $nextcoins = $coins +
            ($i == 0 ? 1 : $box[$i - 1]) *
            $box[$i] *
            ($i == scalar @box - 1 ? 1 : $box[$i + 1]);
        my @nextbox = @box;
        splice @nextbox, $i, 1;
        push @q, { coins => $nextcoins, box => \@nextbox };
    }
}

say $maxcoins;
