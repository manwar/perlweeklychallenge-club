#!/usr/bin/env perl

use 5.026;
use strict;
use autodie;
use warnings;
use List::Util qw(min max);

sub main {
    die "usage: $0 STRING STRING\n" unless @ARGV == 2;
    my ($s1, $s2) = @ARGV;

    say jaro_winkler_distance($s1, $s2);

    return 0;
}

sub jaro_winkler_distance {
    my ($s1, $s2) = @_;

    return 1 - jaro_winkler_similarity($s1, $s2);
}

sub jaro_winkler_similarity {
    my ($s1, $s2) = @_;

    my $similarity = jaro_similarity($s1, $s2);
    my $length = common_prefix_length($s1, $s2);
    my $scaling_factor = 0.1;

    return $similarity + $length * $scaling_factor * (1 - $similarity);
}

sub jaro_similarity {
    my ($s1, $s2) = @_;

    my ($matchings, $transpositions) = matching_characters_and_transpositions($s1, $s2);

    return
        $matchings == 0
        ? 0
        : ($matchings/length($s1) + $matchings/length($s2) + ($matchings-$transpositions)/$matchings) / 3;
}

sub matching_characters_and_transpositions {
    my ($s1, $s2) = @_;

    my $l1 = length $s1;
    my $l2 = length $s2;

    my $farthest = int(max($l1, $l2)/2) - 1;

    my $m1 = matching_characters($s1, $s2, $l1, $l2, $farthest);
    my $m2 = matching_characters($s2, $s1, $l2, $l1, $farthest);

    my $matchings = min(length $m1, length $m2);

    my $transpositions = 0;
    for (my $i=0; $i<$matchings; ++$i) {
        if (substr($m1, $i, 1) ne substr($m2, $i, 1)) {
            ++$transpositions;
        }
    }

    return ($matchings, int($transpositions/2));
}

sub matching_characters {
    my ($s1, $s2, $l1, $l2, $farthest) = @_;

    my $matching = '';

    for my $i (0 .. $l1) {
        my $char = substr($s1, $i, 1);
        for my $j (max(0, $i-$farthest) .. min($i+$farthest, $l2-1)) {
            if ($char eq substr($s2, $j, 1)) {
                $matching .= $char;
                last;
            }
        }
    }

    return $matching;
}

sub common_prefix_length {
    my ($s1, $s2) = @_;

    my $length = 0;
    for my $i (0 .. 3) {
        last if substr($s1, $i, 1) ne substr($s2, $i, 1);
        ++$length;
    }
    return $length;
}

main();
