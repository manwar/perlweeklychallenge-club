#!/usr/bin/perl
use 5.030;
use warnings;

my ($items1, $items2) = @ARGV;

my %merged;
foreach my $item (map { [split /\,/] } split /\s+/, "$items1 $items2") {
    $merged{$item->[0]} += $item->[1];
}

say q{[ }, 
    (join q{, }, map { "[$_,$merged{$_}]" } sort { $merged{$b} <=> $merged{$a} } keys %merged),
q{ ]};
