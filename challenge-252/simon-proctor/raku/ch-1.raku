#!/usr/bin/env raku

#| Run the test suite
multi sub MAIN('test') {
    use Test;
    is specials(1,2,3,4), (1,2,4);
    is squares(1,2,4), (1,4,16);
    is specials(2, 7, 1, 19, 18, 3), (2,7,1,3);
    done-testing;
}

#| Find the sum of the special numbers
multi sub MAIN(
    *@vars where all(@vars) ~~ Int #= List of integers
) {
    say [+] squares(specials(|@vars));
}

sub specials(*@vars) {
    @vars.grep({ @vars.elems %% ++$ });
}

sub squares(*@vars) {
    @vars.map( *² );
}

