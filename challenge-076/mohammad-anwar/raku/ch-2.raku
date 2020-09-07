#!/usr/bin/env raku

#
# Perl Weekly Challenge - 076
#
# Task #2: Word Search
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-076
#

use v6.d;
our $DEBUG = 0;

sub MAIN(Str :$dict where *.IO.f,
         Str :$grid where *.IO.f,
         Int :$size where $size > 0) {

    my @words   = Empty;
    my $index   = 1;
    my @puzzles = fetch-puzzles($grid, $size);
    my $total   = @puzzles.elems;

    for @puzzles -> $puzzle {
        say sprintf("Processing record %d of %d.", $index++, $total);
        my $words = word-search($dict, $size, $puzzle.Str);
        if $words.elems > 0 {
            @words.push: $words;
        }
    }

    .say for @words;
}

sub word-search(Str $dict, Int $size, Str $puzzle) {

    my @words = Empty;
    for $dict.IO.lines -> $word {
        next unless $word.chars >= $size;
        @words.push: $word if $puzzle ~~ /:i $word/;
    }

    return @words;
}


sub fetch-puzzles(Str $grid, $size) {

    my @data = Empty;
    for $grid.IO.lines -> $line {
        @data.push: $line;
    }

    my ($origin, $matrix) = horizontals($size, @data);
    $matrix = verticals($size, $origin, $matrix);
    $matrix = top-right-diagonal($size, $origin, $matrix);
    $matrix = top-left-diagonal($size, $origin, $matrix);

    my $cols    = $origin.[0].elems;
    my $rows    = $origin.elems;
    my @puzzles = Empty;
    for $matrix.sort({ $^b.value <=> $^a.value }) -> $pair {
        my $string = $pair.keys;
        say "$string =>" ~ $matrix.{$string} if $DEBUG;
        @puzzles.push: $string;
    }
    say "Matrix [$rows x $cols]: " ~ @puzzles.elems;

    return @puzzles;
}

sub horizontals(Int $size, $data) {

    my @origin = Empty;
    my %matrix = Empty;
    for $data.<> -> $line is copy {
        $line ~~ s:g/\s//;

        my $l = "";
        my @l = Empty;
        for $line.comb -> $char {
            @l.push: $char;
            $l ~= $char;
        }
        next unless $l.chars >= $size;

        @origin.push: [ |@l ];
        %matrix.{$l} = $l.chars;
        %matrix.{$l.flip} = $l.chars;
    }

    return ([ |@origin ], { %matrix });
}

sub verticals($size, $origin, $matrix is copy) {

    my $cols = $origin.[0].elems;
    my $rows = $origin.elems;
    say "verticals() [$rows][$cols]." if $DEBUG;
    for 0 .. $cols-1 -> $c {
        my $l = "";
        for 0 .. $rows-1 -> $r {
            $l ~= $origin.[$r][$c];
            say "[$r][$c]" if $DEBUG;
        }
        say "------" if $DEBUG;
        next unless $l.chars >= $size;

        $matrix.{$l} = $l.chars;
        $matrix.{$l.flip} = $l.chars;
    }

    return $matrix;
}

sub top-right-diagonal($size, $origin, $matrix is copy) {

    say "top-right-diagonal()" if $DEBUG;
    my ($row, $col);

    $row = 0;
    while $row < $origin.elems {
        my $l = "";
        my $r = $row;
        $col  = $origin.[0].elems - 1;
        while $col >=0 && $r >= 0 {
            $l ~= $origin.[$r][$col];
            say "[$r][$col]" if $DEBUG;
            $r--;
            $col--;
        }
        $row++;
        say "------" if $DEBUG;
        next unless $l.chars >= $size;

        $matrix.{$l} = $l.chars;
        $matrix.{$l.flip} = $l.chars;
    }

    $col = $origin.[0].elems - 2;
    while $col >= 0 {
        my $l = "";
        my $c = $col;
        $row  = $origin.elems - 1;
        while $row >= 0 && $c >= 0 {
            $l ~= $origin.[$row][$c];
            say "[$row][$c]" if $DEBUG;
            $row--;
            $c--;
        }
        $col--;
        say "------" if $DEBUG;
        next unless $l.chars >= $size;

        $matrix.{$l} = $l.chars;
        $matrix.{$l.flip} = $l.chars;
    }

    return $matrix;
}

sub top-left-diagonal($size, $origin, $matrix) {

    say "top-left-diagonal()" if $DEBUG;
    my ($row, $col);

    $row = 0;
    while $row < $origin.elems-1 {
        my $l = "";
        $col  = 0;
        my $r = $row;
        while $col < $origin.[0].elems && $r >= 0 {
            $l ~= $origin.[$r][$col];
            say "[$r][$col]" if $DEBUG;
            $r--;
            $col++;
        }
        $row++;
        say "------" if $DEBUG;
        next unless $l.chars >= $size;

        $matrix.{$l} = $l.chars;
        $matrix.{$l.flip} = $l.chars;
    }

    $col = 1;
    while $col < $origin.[0].elems-1 {
        my $l = "";
        my $c = $col;
        $row  = $origin.elems - 1;
        while $row >= 0 && $c < $origin.[0].elems - 1 {
            $l ~= $origin.[$row][$c];
            say "[$row][$c]" if $DEBUG;
            $row--;
            $c++;
        }
        $col++;
        say "------" if $DEBUG;
        next unless $l.chars >= $size;

        $matrix.{$l} = $l.chars;
        $matrix.{$l.flip} = $l.chars;
    }

    return $matrix;
}
