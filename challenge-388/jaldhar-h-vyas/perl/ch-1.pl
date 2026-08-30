#!/usr/bin/perl
use 5.40.1;
use warnings;

sub dyckWords($n, $up, $down, $prefix) {
    if (length $prefix == 2 * $n) {
        return ($prefix);
    }

    my @words;

    if ($up < $n) {
        push @words, dyckWords($n, $up + 1, $down, $prefix . 'U');
    }

    if ($down < $up) {
        push @words, dyckWords($n, $up, $down + 1, $prefix . 'D');
    }

    return @words;
}

my ($n) = @ARGV;

my @words = dyckWords($n, 0, 0, q{});

say q{(}, (join q{, }, map { "\"$_\"" } sort @words), q{)};
