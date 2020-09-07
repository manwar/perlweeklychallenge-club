#!/usr/bin/env raku

use v6;

my %*SUB-MAIN-OPTS = :named-anywhere;

#| Given an amount and a list of valid coins show all the combinations of change
sub MAIN (
    UInt $amount where * > 0, #= Amount to make change of
    *@coins where { .all ~~ Int && .all > 0 }, #= Valid coins
    Bool :v(:$verbose) = False, #= Print the complete list of combinations 
    Str :p(:$pretty) = "", #= If in verbose mode and set to a value uses this as the coin type (eg 'p' or 'c')
) {
    my @change = make-change( $amount, @coins );
    say @change.elems;
    if $verbose {
        if $pretty {
            for @change -> @list {
                @list.Bag.pairs.sort( { $^b.key cmp $^a.key } ).map( { "{$_.value} x {$_.key}{$pretty}" } ).join( ", ").say;
            }
        } else {
            .join(", ").say for @change;
        }
    }
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
    @result = @result.map( { $_.sort.reverse.Array } ).unique( with => &[~~] ).sort( { $^a.elems cmp $^b.elems } );
    %change_cache{$amount} = @result;
    return @result;
}
