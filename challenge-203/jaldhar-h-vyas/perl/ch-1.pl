#!/usr/bin/perl
use 5.030;
use warnings;

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

my @args = @ARGV;
my @quadruplets;

for my $combo (combinations(\@args, 4)) {
    my @sorted = sort {$a <=> $b} @{$combo};
    if ($sorted[0] + $sorted[1] + $sorted[2] == $sorted[3]) {
        push @quadruplets, \@sorted;
    }
}

say scalar @quadruplets;
