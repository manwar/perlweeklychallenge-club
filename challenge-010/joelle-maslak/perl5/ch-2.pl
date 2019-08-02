#!/usr/bin/env perl
use v5.24;
use strict;
use warnings;

#
# ASSUMPTION: case doesn't matter
#

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use List::Util qw(first max min);

MAIN: {
    usage() if ( @ARGV < 2 );
    usage() if ( @ARGV > 3 );

    my $s1 = $ARGV[0];
    my $s2 = $ARGV[1];
    my $p  = $ARGV[2] // 0.1;

    say jaro_winkler_distance(fc($s1), fc($s2), $p);
}

sub usage() {
    say STDERR "Please pass two strings and an optional p-value";
    exit 1;
}

sub jaro_winkler_distance($s1, $s2, $p) {
    my $jaro_distance = jaro_distance($s1, $s2);
    my $jaro_similarity = 1.0 - $jaro_distance;

    # compute prefix length similarity
    my $min_len = min(length $s1, length $s2);
    my $prefix_len = $min_len < 4 ? $min_len : 4;
    my $l = first   { substr($s1, 0, $_) eq substr($s2, 0, $_) } reverse (0..$prefix_len);

    my $jw_similiarity = $jaro_similarity + ($l * $p * $jaro_distance);
    return 1 - $jw_similiarity; # Distance
}

sub jaro_distance($s1, $s2) {
    return 0 if $s1 eq $s2;

    my (@s1) = split '', $s1;
    my (@s2) = split '', $s2;

    my (@s1_matches) = map { undef } @s1;
    my (@s2_matches) = map { undef } @s2;

    my $max_len = max(length $s1, length $s2);
    my $match_dist = int $max_len / 2 - 1;
    $match_dist = 0 if $match_dist < 1;

    # Get matches
    for (my $i=0; $i<length($s1); $i++) {
        my $start = $match_dist <= $i ? $i - $match_dist : 0;
        my $end   = $i + $match_dist < length($s2) ? $i + $match_dist : length($s2) - 1;

        for (my $j=$start; $j<=$end; $j++) {
            next if defined $s2_matches[$j];

            if ($s1[$i] eq $s2[$j]) {
                $s1_matches[$i] = $s1[$i];
                $s2_matches[$j] = $s2[$j];
                last;
            }
        }
    }

    # Get rid of non-matching characters
    @s1_matches = grep { defined } @s1_matches;
    @s2_matches = grep { defined } @s2_matches;

    my $m = scalar(@s1_matches);
    return 1 if $m == 0;  # We have no matches.

    # Get transpositions
    my $t = 0;
    for (my $x=0; $x<$m; $x++) {
        $t += .5 if $s1_matches[$x] ne $s2_matches[$x];
    }

    my $jaro_similarity = (1/3 * ( $m/length($s1) + $m/length($s2) + ($m-$t)/$m ) );
    my $jaro_difference = 1 - $jaro_similarity;
    
    return $jaro_difference;
}

