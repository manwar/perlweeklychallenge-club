#!raku


sub MAIN( Int $limit where { $limit > 0 } = 5 ) {
    my @digits = 1 .. 9;
    @digits.push: 0;
    my $start =  @digits.join;
    
    my @pandigital = lazy gather {
        for $start ..^ Inf -> $current {
            next if $start ~~ / ^0+ /;
            my $found = 0;
            $found += $current.comb.grep( $_ ).so ?? 1 !! 0 for @digits;
            take $current if $found >= @digits.elems;
        }
    }

    @pandigital[ $_ ].say for 0 ..^ $limit;

}
