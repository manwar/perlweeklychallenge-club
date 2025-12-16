#!/usr/bin/perl
use 5.038;
use warnings;

my @words = @ARGV;
my @substrings;

for my $i (0 .. scalar @words - 1) {
    for my $j (0 .. scalar @words - 1) {
        if ($i != $j && index($words[$j], $words[$i]) != -1) {
            unless (grep { $_ eq $words[$i] } @substrings) {
                push @substrings, $words[$i];
                last;
            }
        }
    }
}

say q{(}, (join q{, }, map { "\"$_\"" } @substrings), q{)};
