#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-010/
# Challenge #2
# Write a script to find Jaro-Winkler distance between two strings.
# For more information check wikipedia page.
# https://en.wikipedia.org/wiki/Jaro%E2%80%93Winkler_distance

use strict;
use warnings;

die "Usage: $0 <string> <string>" if (scalar @ARGV != 2);

#Using lower case for checking similarity
my $dw = 1 - simw(map {lc} @ARGV);;
print 'Jaro-Winkler distance: '.sprintf("%.3f",$dw).$/;

exit 0;

#Jaro-Winkler similarity
sub simw {
    my ($s1,$s2,$p) = @_;
    #Scaling factor
    $p = 0.1 unless $p;

    my $simj = simj($s1,$s2);

    my $prefix = _common_prefix($s1,$s2);

    my $simw = $simj + $prefix * $p * (1- $simj);

    return $simw;
}

#Common prefix
sub _common_prefix {
    my ($s1,$s2) = @_;

    my @chr1 = split //, $s1;
    my @chr2 = split //, $s2;

    my $prefix = 0;
    do {
        last unless ( defined $chr2[$_] && $chr1[$_] eq $chr2[$_] );
        $prefix++;
    } for 0..3; #prefix up to 4
    return $prefix;
}

#Jaro similarity
sub simj {
    my ($s1,$s2) = @_;

    my $l1 = length($s1);
    my $l2 = length($s2);

    #Matching distance
    my $max_l = $l1 > $l2 ? $l1 : $l2;
    my $match_dist = int($max_l / 2 - 1);

    my @chr1 = split //, $s1;
    my @chr2 = split //, $s2;
    my @chr2tmp = @chr2;

    my @matches;
    my %matches_position;

    for (my $i = 0; $i < $l1; $i++) {

        my $init = $i - $match_dist;
        $init = 0 if $init < 0;

        my $end = $i + $match_dist + 1;
        $end = $l2 if $end > $l2;

        for (my $j = $init; $j < $end; $j++) {
            if ($chr1[$i] eq $chr2tmp[$j]){
                push @matches, $chr1[$i];
                $matches_position{$j} = $i; #required to detect transpositions
                $chr2tmp[$j]='-'; # avoid matching with the same character
                last;
            }
        }
    }

    my $m = @matches;
    #Jaro similarity is 0 if there are no matches
    return 0 if ($m == 0);

    my $transpositions = 0;
    my $j = 0;
    for (my $i = 0; $j < $m; $i++) {
        if (exists $matches_position{$i}){
            $transpositions++ if( $chr2[$i] ne $matches[$j]);
            $j++;
        }
    }

    my $t = $transpositions / 2;

    my $simj = 1/3 * ($m/$l1 + $m/$l2 + ($m - $t)/$m);

    return $simj;
}
