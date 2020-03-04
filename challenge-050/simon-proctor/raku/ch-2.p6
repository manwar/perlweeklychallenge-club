#!/usr/bin/env raku

use v6;

#| Generate and display a random list of n integers (default 10) between 1 and max (default 30)
#| Then print the Noble Integers in the list
multi sub MAIN (
    UInt :n(:$number) = 10, #= Number of values to generate
    UInt :m(:$max) where { $max > $number } = 50  #= Maximum value (must be greater then $n)
) {
    my @list = (1..$max).pick($number);
    say "Generated List : {@list.join(",")}";
    MAIN( @list );
}

#| Given a list of Integers print the noble integers in the list
multi sub MAIN (
    *@values is copy where { $_.all ~~ UInt } #= Space seperated list of Intgers to check
) {
    @values.=sort;
    while ( @values ) {
        my $val = @values.shift;
        say $val if $val == @values.elems;
    }
}
