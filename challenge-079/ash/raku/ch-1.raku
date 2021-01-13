#!/usr/bin/env raku
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-079/#
#
# Comments: 
#
# This program implements a fast algorithm.
#
# Output:
#
# $ raku ch-1.raku 42
# 108
#
# $ raku ch-1.raku 123456789
# 1644989771

unit sub MAIN($n = 42, :v(:$verbose));

my @scale = (1, 2 * * ...^ * > $n);

my $total-bits = 0;
for @scale -> $pwr {

    my $fill = ($n + 1) / (2 * $pwr);
    my $max = $pwr * 2;
    say "\n$pwr: fill=$fill, max=$max" if $verbose;

    my $fill-full = $fill.Int;
    my $fill-frac = $fill - $fill-full;
    
    my $bits-full = $fill-full * $pwr;
    my $bits-frac = 0;

    if $fill-frac > 0.5 {
        $bits-frac = ($fill-frac - 0.5) * $max;
        say "($fill-frac - 0.5) * $pwr" if $verbose;
    }

    my $bits = $bits-full + $bits-frac;
    say "bits-full=$bits-full, bits-frac=$bits-frac, bits=$bits" if $verbose;

    $total-bits += $bits;
}
say $total-bits;
