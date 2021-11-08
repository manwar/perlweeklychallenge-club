#!/usr/bin/env raku

sub conflict-intervals ( +@intervals ) {;
    @intervals.grep: -> $r { @intervals.head($++).first: $r.bounds.any ~~ * }
}

multi MAIN (*@r) { #= A C  B D  F H  E G
     @r
     andthen .map: -> $s, $e { $s .. $e }\
     andthen conflict-intervals $_
     andthen .say
}

multi MAIN (Bool :test($)!) {
     use Test;
     is-deeply conflict-intervals( 1..4, 3..5, 6..8, 12..13, 3..20), (3..5, 3..20);
     is-deeply conflict-intervals( 3..4, 5..7, 6..9, 10..12), (6..9,);
     is-deeply conflict-intervals( 3..4, 5..7, 6..9, 10..14, 13..15 ), (6..9, 13..15);
     done-testing;
}
