#!/usr/bin/perl
use 5.030;
use warnings;

my @list = sort { $a <=> $b } @ARGV;
my $mid = scalar @list / 2;
my @sorted;
my $odd = scalar @list % 2 == 1;

if ($odd) {
    push @sorted, $list[$mid];
}

for my $i (0 .. $mid - 1) {
    if ($odd) {
        push @sorted, $list[scalar @list - $i - 1], $list[$i];
    } else {
        push @sorted, $list[$i], $list[scalar @list - $i - 1];
    }
}

say q{(}, (join q{,}, @sorted), q{)};
