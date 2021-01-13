#!/usr/bin/env raku

#
# Perl Weekly Challenge - 079
#
# Task #2: Trapped Rain Water
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-079
#

use v6.d;

subset PositiveInt of Int where * >= 0;

sub MAIN(*@N where @N.elems > 1 && all(@N) ~~ PositiveInt) {
    chart(@N).say;
    trapped-rain-water(@N).say;
}

#
#
# SUBROUTINES

sub trapped-rain-water(*@array where .all ~~ PositiveInt) {

    my @a   = ();
    my $p   = 0;
    my $trw = 0;
    for @array -> $n {
        if $p == 0 || $p >= $n {
            $p = $n if @a == 0 || ($p == 0 && $n > $p);
            @a.push: $n;
        }
        else {
            @a.push: $n;
            $trw += fetch-trapped-water(@a);
            @a = $n;
            $p = $n if $p < $n;
        }
    }

    # are there any left over to be processed?
    if @a.elems > 1 {
        $trw += fetch-trapped-water(@a);
    }

    return $trw;
}

sub fetch-trapped-water(*@array where .all ~~ PositiveInt) {

    # remove any smaller tower from the start
    repeat {
        if @array[0] == 0 {
            @array.shift;
        }
    } until @array[0] > 0;

    # remove any smaller tower from the end
    repeat {
        if @array[*-1] < @array[*-2] {
            @array.pop;
        }
    }
    until @array[*-1] > @array[*-2];

    my $max = (@array[0], @array[*-1]).min * (@array.elems - 2);
    $max -= @array[$_] for 1..@array.elems - 2;

    return $max;
}

sub chart(*@list where @list.elems > 1 && all(@list) ~~ PositiveInt --> Str) {

    my $max   = @list.max;
    my $chart = [];
    my $row   = 1;
    for 1 .. $max -> $n {
        my Str $data = "";
        for 0 .. @list.elems-1 -> $i {
            if $row <= @list[$i] {
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
    $line ~= "_ " for 0 .. @list.elems;
    $size ~= @list.join(" ");

    return ($histogram, $line, $size).join("\n");
}
