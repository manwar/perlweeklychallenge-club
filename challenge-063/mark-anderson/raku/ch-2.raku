#!/usr/bin/env raku

sub MAIN(Str $str = "xyxx") {
    my @arr = $str.comb;

    for 1 .. Inf -> $i {
        @arr .= rotate($i % $str.chars);    
        say $i and last if @arr.join eq $str;
    }    
}
