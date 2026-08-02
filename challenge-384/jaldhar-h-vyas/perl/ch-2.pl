#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($binary) = @ARGV;

my @results;

for my $i (0 .. (length $binary) - 1) {
    for my $j (1 .. (length $binary) - $i) {
        my $substring = substr $binary, $i, $j;
        if (($substring =~ /^(0+)(1+)$/ || $substring =~ /^(1+)(0+)$/) &&
        length $1 == length $2) {
            push @results, $substring;
        }
    }
}

say q{(}, (join q{, }, map{ "\"$_\"" } @results) , q{)};
