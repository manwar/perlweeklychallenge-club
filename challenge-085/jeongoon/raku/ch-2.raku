#!/usr/bin/env raku

# test with:
# raku ch-2.raku <N>
# raku ch-2.raku --log <N> # find by using log()

sub largest-factor ( Int \n --> Int ) { n.sqrt.Int }

sub pow-utf8 ( Int $n ) {
    state @pow = <⁰ ¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹>;
    @pow[ $n.comb ].join
}



multi sub MAIN (1) { say "1 as 1²" }

multi sub MAIN ( Int \N where * > 0 ) {
    if N.is-prime {
        say "0 as {N} is a prime number.";
    }
    else {
        my $lf = largest-factor(N);
        ( $lf ... 2 ).
        lazy.
        map(
            -> $a {
                ([\×] ($a,$a ... ∞)). # produce a¹, a², a³
                lazy.                   # in lazy way
                skip(1).                # but we don't need first one (a¹)
                kv.
                map(
                    -> \β, \κ {
                        if    N == κ { ($a => β + 2) }  # as `b' value
                        elsif N <= κ { last  }
                        else          { Empty }
                    } ).Slip
            } ).first
        andthen say "1 as {.key}{pow-utf8(.value)}"
        orelse  say "0"
    }
}

multi sub MAIN ( Int \N where * > 0, Bool:D :$log ) {
    $*ERR.say( "alternative solution using log() ..." );
    if N.is-prime {
        say "0 as {N} is a prime number.";
    }
    else {
        my $lf = largest-factor(N);
        ( $lf ... 2 ).
        lazy.map(
            { my $pow = log( N, $_ ).Rat( 1e-32 );
              ($_ => $pow.Int) if $pow.denominator == 1;
            }
        ).first
        andthen say "1 as {.key}{pow-utf8(.value)}"
        orelse  say "0"
    }
}
