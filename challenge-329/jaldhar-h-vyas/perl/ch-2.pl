#!/usr/bin/perl
use 5.038;
use warnings;
use builtin qw/ true /;
no warnings qw/experimental::builtin/;

my $str = shift;
my %substrings;

for my $i (0 .. length($str) - 1) {
    for my $j ($i .. length($str)) {
        $substrings{substr($str, $i, $j)} = true;
    }
}

for my $substring (sort { length $b <=> length $a } keys %substrings) {
    my %lower;
    my %upper;

    for my $c (split //, $substring) {
        if ($c eq lc $c) {
            $lower{$c}++;
        } else {
            $upper{lc $c}++;
        }
    }

    if ((join q{}, sort keys %lower) eq (join q{}, sort keys %upper)) {
        say $substring;
        last;
    }
}
