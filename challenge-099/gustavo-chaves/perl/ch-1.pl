#!/usr/bin/env perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-099/
# TASK #1 › Pattern Match

use 5.030;
use warnings;

my ($S, $P) = @ARGV;

say "Pattern: '$P'";

say match($P, $S) ? "Matches: " : "Does not match: ", "'$S'";

sub match {
    my ($pattern, $string) = @_;

    my ($s, $p) = (0, 0);

  CHAR:
    while ($p < length($pattern) && $s < length($string)) {
        my $c = substr($pattern, $p, 1);

        if ($c eq '?') {
            ++$s;
            ++$p;
        } elsif ($c eq '*') {
            my $patterntail = substr($pattern, $p+1);
            for (my $i=$s; $i < length($string); ++$i) {
                return 1 if match($patterntail, substr($string, $i));
            }
            return 0;
        } elsif ($c eq substr($string, $s, 1)) {
            ++$s;
            ++$p;
        } else {
            return 0;
        }
    }

    return $p == length($pattern) && $s == length($string);
}
