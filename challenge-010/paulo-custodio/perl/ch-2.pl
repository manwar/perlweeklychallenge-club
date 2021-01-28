#!/usr/bin/perl

# Challenge 010
#
# Challenge #2
# Write a script to find Jaro-Winkler distance between two strings. For more
# information check wikipedia page.

use strict;
use warnings;
use 5.030;

sub jaro_similarity {
    my($s1, $s2) = @_;

    return 1 if $s1 eq $s2;                 # strings equal => 1

    my @s1 = split //, $s1; my $len1 = length($s1);
    my @s2 = split //, $s2; my $len2 = length($s2);

    # max distance between matching characters
    my $max_dist = int(max($len1, $len2) / 2) - 1;

    # count number of unique matches - same letters less than max_dist appart
    my $match = 0;
    my @found_s1;
    my @found_s2;
    for my $i (0 .. $len1-1) {
        for my $j (max(0, $i-$max_dist) .. min($len2-1, $i+$max_dist)) {
            if ($s1[$i] eq $s2[$j] &&       # same character
                !$found_s2[$j])             # and not already matched
            {
                $found_s1[$i]=1;            # mark these ...
                $found_s2[$j]=1;            # ... as found
                $match++;
                last;
            }
        }
    }
    return 0 if $match==0;                  # no matched characters => 0

    # count transpositions: The first assigned character on one string is
    # compared to the first assigned character on the other string. If the
    # characters are not the same, half of a transposition has occurred. Then
    # the second assigned character on one string is compared to the second
    # assigned character on the other string, etc. The number of mismatched
    # characters is divided by two to yield the number of transpositions.
    my $transp = 0;
    my $pos_s2 = 0;
    for my $i (0 .. $len1-1) {
        if ($found_s1[$i]) {        # there is a match in s1, find first match in s2
            $pos_s2++ while !$found_s2[$pos_s2];
            if ($s1[$i] ne $s2[$pos_s2++]) {
                $transp++;
            }
        }
    }
    $transp /= 2;

    my $jaro_similarity = ($match/$len1 + $match/$len2 + ($match-$transp)/$match) / 3;
    return $jaro_similarity;
}

sub jaro_winkler_similarity {
    my($s1, $s2) = @_;

    my @s1 = split //, $s1; my $len1 = length($s1);
    my @s2 = split //, $s2; my $len2 = length($s2);

    # find longest common prefix l
    my $l = 0;
    $l++ while ($l < min(4, $len1, $len2) && $s1[$l] eq $s2[$l]);

    # constant p
    my $p = 0.1;

    my $jaro_similarity = jaro_similarity($s1, $s2);
    my $jaro_winkler_similarity = $jaro_similarity + $l*$p*(1 - $jaro_similarity);
    return $jaro_winkler_similarity;
}

sub jaro_winkler_distance {
    my($s1, $s2) = @_;
    return 1-jaro_winkler_similarity($s1,$s2);
}

sub min {
    my($min, @a) = @_;
    for (@a) {
        $min = $_ if $min > $_;
    }
    return $min;
}

sub max {
    my($max, @a) = @_;
    for (@a) {
        $max = $_ if $max < $_;
    }
    return $max;
}


say jaro_winkler_distance(@ARGV);
