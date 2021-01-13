#!/usr/bin/env raku

use v6;

#| Given a string print the FNR character for each sub string
#| Prints # if there isn't one at a given point
sub MAIN ( Str $input ) {
    my @codes = $input.comb;
    my @in;
    my @out;
    
    for @codes -> $c {
        @in.push($c);
        @out.push(fnr(@in));
    }

    say @out.join("");
}

sub fnr ( @values ) {
    my $counts = bag(@values);
    
    for @values.reverse -> $v {
        return $v if $counts{$v} ~~ 1;
    }
    
    return '#';
}

