#! /usr/bin/raku

use Test;

plan 5;

is(meetingpoint('ULD'), False, 'example 1');
is(meetingpoint('ULDR'), True, 'example 2');
is(meetingpoint('UUURRRDDD'), False, 'example 3');
is(meetingpoint('UURRRDDLLL'), True, 'example 4');
is(meetingpoint('RRUULLDDRRUU'), False, 'example 5');

sub counterify(@a) {
    my %m;
    for @a -> $i {
        %m{$i}++;
    }
    return %m;
}

sub defget(%m, $v) {
    %m{$v} || 0;
}

sub meetingpoint($a) {
    my %c = counterify($a.comb);
    defget(%c, 'U') == defget(%c, 'D') && defget(%c, 'L') == defget(%c, 'R')
}
