#!/usr/bin/perl
use v5.38;

my $str = shift;
my %order;

for my $w (split /\s+/, $str) {
    my ($word, $pos) = $w =~ /(.+)(\d+)/;
    $order{$pos} = $word;
}

say join q{ }, map { $order{$_} } sort keys %order;
