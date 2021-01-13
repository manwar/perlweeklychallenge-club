#!/usr/bin/perl

#
# Perl Weekly Challenge - 079
#
# Task #2: Trapped Rain Water
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-079
#

use strict;
use warnings;
use List::Util qw(min max);

my $L = $ARGV[0] || "2, 1, 4, 1, 2, 5";
printf("%s\n\n", histogram(to_arrayref($L)));
printf("Trapped Rain Water: %d\n", trapped_rain_water(to_arrayref($L)));

#
#
# SUBROUTINES

sub trapped_rain_water {
    my ($arrayref) = @_;

    my @a   = ();
    my $p   = 0;
    my $trw = 0;
    foreach my $n (@$arrayref) {
        if ($p == 0 || $p >= $n) {
            $p = $n if (@a == 0 || ($p == 0 && $n > $p));
            push @a, $n;
        }
        else {
            push @a, $n;
            $trw += fetch_trapped_water(@a);
            @a = ($n);
            $p = $n if ($p < $n);
        }
    }

    # are there any left over to be processed?
    if (@a > 1) {
        $trw += fetch_trapped_water(@a);
    }

    return $trw;
}

sub fetch_trapped_water {
    my (@array) = @_;

    # remove any smaller tower from the start
    do {
        if ($array[0] == 0) {
            shift @array;
        }
    } until ($array[0] > 0);

    # remove any smaller tower from the end
    do {
        if ($array[-1] < $array[-2]) {
            pop @array;
        }
    }
    until ($array[-1] > $array[-2]);

    my $max = min($array[0], $array[-1]) * (@array - 2);
    $max -= $array[$_] for 1..@array-2;

    return $max;
}

# Borrowed as is from past solution of mine.
sub histogram {
    my ($arrayref) = @_;

    my $max   = max(@$arrayref);
    my $chart = [];
    my $row   = 1;
    foreach (1..$max) {
        my $data = "";
        foreach my $i (0..$#$arrayref) {
            if ($row <= $arrayref->[$i]) {
                $data .= " #";
            }
            else {
                $data .= "  ";
            }
        }
        $row++;
        push @$chart, sprintf("%d%s", $_, $data);
    }

    my ($histogram, $line, $size) = ("", "", "  ");
    $histogram = join "\n", (reverse @$chart);
    $line .= "_ " for (0..$#$arrayref + 1);
    $size .= join " ", @$arrayref;

    return join "\n", $histogram, $line, $size;
}

sub to_arrayref {
    my ($l) = @_;

    die "ERROR: Missing list.\n"      unless defined $l;
    die "ERROR: Invalid list [$l].\n" unless ($l =~ /^[\-?\d\,?\s?]+$/);

    $l =~ s/\s//g;
    return [ split /\,/, $l ];
}
