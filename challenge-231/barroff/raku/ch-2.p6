#!/usr/bin/env raku

use v6.d;

my $passenger-details = / \d ** 10 <:Lu> (\d\d) \d\d /;

sub senior-citizens(@passengers where { @_.all ~~ $passenger-details }) {
    (grep { $_ ~~ $passenger-details; $0 ≥ 60 }, @passengers).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is senior-citizens(["7868190130M7522", "5303914400F9211", "9273338290F4010"]),
        2, 'works for ("7868190130M7522", "5303914400F9211", "9273338290F4010")';
    is senior-citizens(["1313579440F2036", "2921522980M5644"]), 0,
        'works for ("1313579440F2036", "2921522980M5644")';
}


#| Take user provided list like "1313579440F2036" "2921522980M5644"
multi sub MAIN(*@passengers where @passengers.elems ≥ 1) {
    say senior-citizens(@passengers);
}
