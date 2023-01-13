#!/usr/bin/perl
use 5.030;
use warnings;

my @list = sort {$a <=> $b} @ARGV;

if (scalar @list < 2) {
    say 0;
} else {
    my %gaps;

    for my $i (1 .. scalar @list - 1) {
        push @{$gaps{($list[$i] - $list[$i - 1])}}, [$list[$i - 1], $list[$i]];
    }

    say scalar @{ $gaps{(sort { $gaps{$b} <=> $gaps{$a} } keys %gaps)[0]} };
}
