#!/usr/bin/env raku

use experimental :cached;

#| Display the first 20 base 10 left-truncatable primes
multi sub MAIN() {
    .say for (1..*).grep( { is-left-truncatable($_) } )[^20];
}

multi sub MAIN("test") is hidden-from-USAGE {
    use Test;
    ok( is-left-truncatable( 9137 ) );
    ok( is-left-truncatable( 137 ) );
    ok( is-left-truncatable( 7 ) );
    ok( ! is-left-truncatable( 101 ) );
    ok( ! is-left-truncatable( 8 ) );
    ok( ! is-left-truncatable( 151 ) );
    done-testing;
}

sub is-left-truncatable( UInt \v ) is pure is cached {
    return False unless v.is-prime;
    return False if v ~~ /0/;
    return True if v.codes == 1;

    return is-left-truncatable( v.substr(1).Int );
}
