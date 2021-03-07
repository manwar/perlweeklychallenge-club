#!/usr/bin/env raku

use v6;

multi sub MAIN("test") is hidden-from-USAGE {
    use Test;
    is( rare( 65 ), True, "65 is rare" );
    is( rare( 66 ), False, "65 is not rare" );
    is( square( 4 ), True, "4 is a square" );
    is( square( 5 ), False, "5 is not a square" );
    is( square( -3 ), False, "No negative squares" );
    is( rares( 2 ), (65,), "One 2 digit rare" );
    done-testing;
}

#| Find all the x digit long Rare numbers
multi sub MAIN(
    UInt \x #= Number of digits
) {
    .say for rares(x);
}

multi sub square(Int $ where * <= 0) returns Bool { False }

my %square-cache;
my \lock = Lock.new;
multi sub square(Int \i --> Bool) {
    lock.protect: {
        %square-cache{i} //= i.sqrt.narrow ~~ Int
    }
}

sub rare(Int \r) returns Bool {
    my \f = r.flip;
    square(r - f) && square( r + f );    
}

sub rares(UInt \l) {
    ((10**(l - 1))..((10**l)-1)).race.grep( -> \i { rare(i) } );
}

