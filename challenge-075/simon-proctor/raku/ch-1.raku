#!/usr/bin/env raku

use v6;

#| Given an amount and a list of valid coins show all the combinations of change
sub MAIN (
    UInt $amount where * > 0, #= Amount to make change of
    *@coins where { .all ~~ Int && .all > 0 }, #= Valid coins
) {
    .join(", ").say for make-change( $amount, @coins );
}

my %change_cache;

multi sub make-change( 0, @coins ) {
    return [[],]
}

multi sub make-change( $amount, @coins ) {
    with %change_cache{$amount} { return |%change_cache{$amount} }
    my @result = [];
    for @coins.grep( * <= $amount ) -> $coin {
        my @list = make-change( $amount - $coin, @coins.grep( * <= $amount ) );
        for @list -> @change {
            @result.push( [$coin, |@change] );
        }        
    }
    @result = @result.map( { $_.sort.Array } ).unique( with => &[~~] );
    %change_cache{$amount} = @result;
    return @result;
}
