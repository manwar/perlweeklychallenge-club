#!/usr/bin/env perl6
use v6;
use experimental :cached;

# Smallest pair is a confusing term.  Is it (A, B) where a is the
# smallest A, or is it where A+B is the smallest A+B?  I'm going with
# the smallest A.

MAIN: {
    my $amicable =
        grep { factorsum($^a) != $^a },
        grep { $^a == factorsum(factorsum($^a)) },
        2..∞;

    say $amicable[0] ~ " " ~ factorsum($amicable[0]);;
}

sub factorsum($num) is cached {
    return sum
        unique :with(&[==]),
        grep { $^a != $num},
        map  { |($^a, $num / $^a) },
        grep { $num %% $^a },
        1..( Int(sqrt($num)) );
}

