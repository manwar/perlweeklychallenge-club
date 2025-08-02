#!/usr/bin/perl
use v5.38;

my $str = shift;

my @input = split //, $str;
my $output;
my $current;

for my $c (@input) {
    if ($c =~ /\d/) {
        $output .= chr(ord($current) + $c);
    } else {
        $current = $c;
        $output .= $c;
    }
}

say $output;
