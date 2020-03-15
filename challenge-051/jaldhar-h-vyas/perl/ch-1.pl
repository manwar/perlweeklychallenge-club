#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub combinations {
    my @list = @{$_[0]};
    my $length = $_[1];

    if ($length <= 1) {
        return map [$_], @list;
    }

    my @combos;

    for (my $i = 0; $i + $length <= scalar @list; $i++) {
        my $val  = $list[$i];
        my @rest = @list[$i + 1 .. $#list];
        for my $c (combinations(\@rest, $length - 1)) {
            push @combos, [$val, @{$c}] ;
        }
    }

    return @combos;
}

my $T = shift;
my @L = @ARGV;

for my $combo (combinations(\@L, 3)) {
    my @triplet = sort{ $a <=> $b } @{$combo};

    my $total = 0;
    for my $elem (@triplet) {
        $total += $elem;
    }

    if ($total == $T) {
        say join q{ }, @triplet;
    }
}