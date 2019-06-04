#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub usage {
    print <<"-USAGE-";
    Usage:
    $0 <string1> <string2>

    <string1>    First string to compare
    <string2>    Second string to compare
-USAGE-
    exit(1);
}

sub prefix {
    my ($string1, $string2) = @_;
    my @prefix1 = split //, substr($string1, 0, 4);
    my @prefix2 = split //, substr($string2, 0, 4);
    my $result = 0;

    for my $i (0 .. 3) {
        if (defined $prefix2[$i] && $prefix1[$i] eq $prefix2[$i]) {
            $result++;
        } else {
            last;
        }
    }

    return $result;
}

sub jaroSimilarity {
    my ($string1, $string2) = @_;

    my $m = 0; # matches
    my $t = 0; # transpositions
    my $near = int((length $string1) / 2 - 1);
    my @chars = split //, $string1;

    for my $i (0 .. scalar @chars - 1) {
        my $pos = index $string2, $chars[$i];
        if ($pos > -1) {
            $m++;
            if (abs($pos - $i) > $near) {
                $t++;
            }
            substr($string2, $pos, 1) = ' '; # prevent using same char twice.
        }
    }
    $t /= 2;

    return $m
      ? 1/3 * ($m / (length $string1) + $m / (length $string2) + ($m - $t) / $m)
      : 0;
}

sub jaroWinklerSimilarity {
    my ($string1, $string2) = @_;
    my $j = jaroSimilarity($string1, $string2);

    return $j + (prefix($string1, $string2) * 0.1) * (1 - $j);
}

sub jaroWinklerDistance {
    my ($string1, $string2) = @_;

    return 1 - jaroWinklerSimilarity($string1, $string2);
}

sub swap {
    my ($s1, $s2) = @_;

    return length $s1 >= length $s2 ? ($s1, $s2) : ($s2, $s1);
}

if (scalar @ARGV != 2) {
   usage();
}

my ($string1, $string2) = swap($ARGV[0], $ARGV[1]);

say jaroWinklerDistance($string1, $string2);