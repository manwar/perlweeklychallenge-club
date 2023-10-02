#!/usr/bin/perl
use 5.030;
use warnings;

my @output;

for my $elem (@ARGV) {
    if ($elem == 0) {
        push @output, 0, 0;
    } else {
        push @output, $elem;
    }

    if (scalar @output == scalar @ARGV) {
        last;
    }
}

say q{(}, (join q{, }, @output), q{)};