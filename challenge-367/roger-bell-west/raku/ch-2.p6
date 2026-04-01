#! /usr/bin/raku

use Test;

plan 5;

is(conflictevents(['10:00', '12:00'], ['11:00', '13:00']), True, 'example 1');
is(conflictevents(['09:00', '10:30'], ['10:30', '12:00']), False, 'example 2');
is(conflictevents(['14:00', '15:30'], ['14:30', '16:00']), True, 'example 3');
is(conflictevents(['08:00', '09:00'], ['09:01', '10:00']), False, 'example 4');
is(conflictevents(['23:30', '00:30'], ['00:00', '01:00']), True, 'example 5');

sub parsetime($t) {
    my @p = $t.split(':');
    @p[0] * 60 + @p[1];
}

sub conflictevents(@a, @b) {
    my @r;
    for (@a, @b) -> @t {
        my $st = parsetime(@t[0]);
        my $en = parsetime(@t[1]);
        if ($st < $en) {
            @r.push([[ $st, $en - 1 ],]);
        } else {
            @r.push([
                           [ $st, 1440 - 1 ],
                           [ 0, $en - 1 ],
                       ]);
        }
    }
    for @r[0].list -> @ra {
        for @r[1].list -> @rb {
            if (@ra[0] <= @rb[1] && @rb[0] <= @ra[1]) {
                return True;
            }
        }
    }
    False;
}
