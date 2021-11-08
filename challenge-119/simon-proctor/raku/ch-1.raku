#!/usr/bin/env raku

#| Given a number N return the nibble swapped version
multi sub MAIN( UInt $N where * <= 255 ) {
    nibble-swap($N).say;
}

multi sub MAIN( "test" ) is hidden-from-USAGE {
    use Test;
    is nibble-swap(101), 86;
    is nibble-swap(18), 33;
    done-testing;
}

sub nibble-swap( $N ) {
    my $bin-n = sprintf( "%08d", $N.base(2) );
    return "{$bin-n.substr(4,4)}{$bin-n.substr(0,4)}".parse-base(2);
}