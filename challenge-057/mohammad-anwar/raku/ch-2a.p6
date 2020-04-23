#!/usr/bin/env perl6

use Test;

my $unit-tests = [
    { in => [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ],
     out => [ "alph", "b", "car", "cadm", "cade", "alpi" ]
    }
];

for $unit-tests -> (:@in, :@out) {
    is-deeply(shortest-unique-prefix(@in), @out);
}

done-testing;

sub shortest-unique-prefix($words where .all ~~ Str) {
    my $p = [];
    for |$words -> $word {
        my $i = 1;
        my $l = $word.chars;
        while $i < $l {
            my $char  = $word.substr(0, $i);
            my $count = $words.grep({ m/^$char/ }).elems;

            $count > 1 && $i++ and next;
            $p.push: $char and last;
        }
    }

    return $p;
}
