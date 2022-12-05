#! /usr/bin/perl6

use Test;

plan 6;

is(digitalclock("?5:00"), 1, 'example 1');
is(digitalclock("?3:00"), 2, 'example 2');
is(digitalclock("1?:00"), 9, 'example 3');
is(digitalclock("2?:00"), 3, 'example 4');
is(digitalclock("12:?5"), 5, 'example 5');
is(digitalclock("12:5?"), 9, 'example 6');

sub digitalclock($hhmm) {
    my $i = index($hhmm, '?');
    if ($i == 0) {
        if (substr($hhmm, 1, 1) le "3") {
            return 2;
        }
        return 1;
    } elsif ($i == 1) {
        if (substr($hhmm, 0, 1) lt "2") {
            return 9;
        }
        return 3;
    } elsif ($i == 3) {
        return 5;
    } elsif ($i == 4) {
        return 9;
    }
    return 0;
}
