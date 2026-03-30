#!/usr/bin/env perl

# Perl Weekly Challenge 367 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-367/

use Modern::Perl;

@ARGV==4 or die "usage: $0 hh:mm hh:mm hh:mm hh:mm\n";

my @t = map {parse_hhmm($_)} @ARGV;
my $overlaps = check_overlap(@t);
say $overlaps ? "true" : "false";

sub check_overlap {
    my(@t) = @_;

    my @A = normalize_interval($t[0], $t[1]);
    my @B = normalize_interval($t[2], $t[3]);

    # Check overlap for all pairings of normalized forms
    for my $a (@A) {
        for my $b (@B) {
            if ($a->[0] < $b->[1] && $b->[0] < $a->[1]) {
                return 1;
            }
        }
    }

    return 0;
}

# Returns list of possible normalized forms
sub normalize_interval {
    my ($s, $e) = @_;

    # Interval does not cross midnight
    if ($e >= $s) {
        return (
            [$s,       $e],         # same day
            [$s+24*60, $e+24*60],   # next day version
        );
    }

    # Interval crosses midnight: e.g. 23:30 ? 00:30
    return (
        [$s,        $e+24*60],  # midnight-span interpreted normally
        [$s-24*60,  $e],        # earlier-day variant
    );
}

# Parse hh:mm into number of minutes since midnight
sub parse_hhmm {
    my($str) = @_;
    my($hh, $mm) = split(/:/, $str, 2);
    return 60*$hh+$mm;
}
