#!/usr/bin/perl
use 5.038;
use warnings;
use builtin qw / true /;
no warnings qw/ experimental::builtin /;

my ($a, $b) = @ARGV;
my @strings = ($a, $b);
my @words = @strings;

while(true) {
    push @words, (join q{}, ($words[-2], $words[-1])); 
    if (length $words[-1] > 51) {
        last;
    }
}

say substr $words[-1], 50, 1;
