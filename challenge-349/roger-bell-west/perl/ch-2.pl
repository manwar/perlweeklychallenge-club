#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(meetingpoint('ULD'), 0, 'example 1');
is(meetingpoint('ULDR'), 1, 'example 2');
is(meetingpoint('UUURRRDDD'), 0, 'example 3');
is(meetingpoint('UURRRDDLLL'), 1, 'example 4');
is(meetingpoint('RRUULLDDRRUU'), 0, 'example 5');

sub counterify($a) {
    my %m;
    foreach my $i (@{$a}) {
        $m{$i}++;
    }
    return \%m;
}

sub defget($m, $v) {
    $m->{$v} || 0;
}

sub meetingpoint($a) {
    my $c = counterify([split '',$a]);
    (defget($c, 'U') == defget($c, 'D') &&
     defget($c, 'L') == defget($c, 'R'))?1:0;
}
