#!/usr/bin/env perl6

use v6.d;

sub MAIN(Str :$string = 'xyxx', Bool :$verbose?) {
    rotate($string, $verbose).say;
}

sub rotate(Str $string where rx:i/^ <[xy]>+ $/, Bool $verbose?) {

    my $size = $string.chars;
    my $temp = $string;
    my $i = 1;
    my $c = 1;
    while $i <= $size {
        my $part_a = substr($temp, 0, $i);
        my $part_b = substr($temp, $i);
        $temp = ($part_b, $part_a).join;
        say "[$c]: [$temp]" if $verbose;
        last if $temp eq $string;

        $i++; $c++;
        $i = 1 if $i > $size;
    }

    return $c;
}
