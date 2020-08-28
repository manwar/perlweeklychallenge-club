#!/usr/bin/perl

#
# Perl Weekly Challenge - 075
#
# Task #2: Largest Rectangle Histogram
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-075
#

use strict;
use warnings;
use Test::More;
use List::Util qw(min max);

is(largest_rectangle_histogram(prepare("2, 1, 4, 5, 3, 7")), 12, "example 1");
is(largest_rectangle_histogram(prepare("3, 2, 3, 5, 7, 5")), 15, "example 2");

done_testing;

#
#
# METHODS

sub largest_rectangle_histogram {
    my ($list) = @_;

    my $i   = 0;
    my $max = 0;
    foreach my $n (@$list) {

        my ($left, $right) = (0, 0);
        $left  = go_left($i, $list)  if ($i > 0);
        $right = go_right($i, $list) if ($i <= $#$list);

        my @heights = (@$list)[$i - $left .. $i + $right];
        my $size    = min(@heights) * @heights;
        $max = $size if ($size > $max);

        $i++;
    }

    return $max;
}

sub go_left {
    my ($i, $list) = @_;

    my $c = $list->[$i];
    my $j = 0;
    while ($i > 0) {
        $i--;
        last if ($list->[$i] < $c);
        $j++;
    }

    return $j;
}

sub go_right {
    my ($i, $list) = @_;

    my $c = $list->[$i];
    my $j = 0;
    while ($i < $#$list) {
        $i++;
        last if ($list->[$i] < $c);
        $j++;
    }

    return $j;
}

sub chart {
    my ($list) = @_;

    my $max   = max(@$list);
    my $chart = [];
    my $row   = 1;
    foreach (1..$max) {
        my $data = "";
        foreach my $i (0..$#$list) {
            if ($row <= $list->[$i]) {
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
    $line .= "_ " for (0..$#$list + 1);
    $size .= join " ", @$list;

    return join "\n", $histogram, $line, $size;
}

sub prepare {
    my ($list) = @_;

    if (defined $list) {
        $list =~ s/\s//g;
        return [ split /\,/, $list ];
    }
}
