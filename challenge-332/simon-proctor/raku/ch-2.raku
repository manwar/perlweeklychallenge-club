#!/usr/bin/env raku

multi sub MAIN(:t(:$test)) is hidden-from-USAGE {
    use Test;
    ok !odd-letters("weekly");
    ok odd-letters("perl");
    ok !odd-letters("challenge");
    done-testing;
}

sub odd-letters (Str $check) {
    ! any($check.comb.Bag.values >>%%>> 2)
}

#|( Given a string print whether each character in
it appears an odd number of times)
multi sub MAIN(Str $s) {say odd-letters($s)}
    
