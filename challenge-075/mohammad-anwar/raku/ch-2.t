#!/usr/bin/env raku

#
# Perl Weekly Challenge - 075
#
# Task #2: Largest Rectangle Histogram
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-075
#

use Test;

is largest-rectangle-histogram(prepare("2, 1, 4, 5, 3, 7")), 12, "example 1";
is largest-rectangle-histogram(prepare("3, 2, 3, 5, 7, 5")), 15, "example 2";

done-testing;

#
#
# METHODS

sub largest-rectangle-histogram($list where .all ~~ Int) returns Int {

    my Int $i   = 0;
    my Int $max = 0;

    for 0 .. $list.elems-1 -> $i {

        my (Int $left, Int $right) = (0, 0);
        $left  = go-left($i, $list)  if $i > 0;
        $right = go-right($i, $list) if $i < $list.elems;

        my $heights = $list.[$i - $left .. $i + $right];
        my $size    = $heights.min * $heights.elems;

        $max = $size if $size > $max;
    }

    return $max;
}

sub go-left(Int $i is copy, $list where .all ~~ Int) returns Int {

    my $c = $list.[$i];
    my $j = 0;
    while $i > 0 {
        $i = $i - 1;
        last if $list.[$i] < $c;
        $j = $j + 1;
    }

    return $j;
}

sub go-right(Int $i is copy, $list where .all ~~ Int) returns Int {

    my $c = $list.[$i];
    my $j = 0;
    while $i < $list.elems-1 {
        $i += 1;
        last if $list.[$i] < $c;
        $j += 1;
    }

    return $j;
}

sub chart($list where .all ~~ Int) {

    my $max   = $list.max;
    my $chart = [];
    my $row   = 1;
    for 1 .. $max -> $n {
        my Str $data = "";
        for 0 .. $list.elems-1 -> $i {
            if $row <= $list.[$i] {
                $data ~= " #";
            }
            else {
                $data ~= "  ";
            }
        }

        $row += 1;

        $chart.push: sprintf("%d%s", $n, $data);
    }

    my (Str $histogram, Str $line, Str $size) = ("", "", "  ");
    $histogram = $chart.reverse.join("\n");
    $line ~= "_ " for 0 .. $list.elems;
    $size ~= $list.join(" ");

    return ($histogram, $line, $size).join("\n");
}

sub prepare(Str $list is copy) {

    return unless $list.defined;

    die "ERROR: Invalid list [$list].\n"
        unless $list ~~ /^[\s?\-?\d\,?\s?]+$/;

    $list ~~ s:g/\s//;
    return [ $list.split(',').map({ .Int }) ];
}

=finish

my $list = prepare($L);
print chart($list), "\n\n";
print "Largest Rectangle Histogram: ", largest_rectangle_histogram($list), "\n";

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
