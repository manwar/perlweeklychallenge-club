#!/bin/env raku

unit sub MAIN(Str:D $str is copy, UInt:D $size, Str:D $filler);

my @s;

while $str.chars > 0 {
    my $s = $str.substr(0, $size);
    @s.push($s ~ $filler x ($size - $s.chars));

    last if $str.chars ≤ $size;
    $str .= substr($size);
}

put @s.join(' ');
