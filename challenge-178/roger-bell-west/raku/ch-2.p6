#! /usr/bin/perl6

use Test;

plan 6;

is(addbizhours("2022-08-01 10:30",   4), "2022-08-01 14:30", 'example 1');
is(addbizhours("2022-08-01 17:00", 3.5), "2022-08-02 11:30", 'example 2');
is(addbizhours("2022-08-01 18:00", 3.5), "2022-08-02 12:30", 'example 3');
is(addbizhours("2022-08-01 19:00", 3.5), "2022-08-02 12:30", 'example 4');
is(addbizhours("2022-08-05 17:00", 3.5), "2022-08-08 11:30", 'example 5');
is(addbizhours("2022-08-01 12:00",  18), "2022-08-03 12:00", 'example 6');

sub addbizhours($start, $delta) {
    $start ~~ /(<[0..9]>+)\D(<[0..9]>+)\D(<[0..9]>+)\D(<[0..9]>+)\D(<[0..9]>+)/;
    my $current = DateTime.new(year => $0,
                               month => $1,
                               day => $2,
                               hour => $3,
                               minute => $4,
                               second => 0);
    my $seconds = 3600 * $delta;
    my $bizdaylength = 3600 * 9;
    unless (isbiz($current)) {
        $current = nextbizstart($current);
    }
    my $ed = nextbizend($current);
    my $remain = ($ed - $current).Int;
    if ($remain < $seconds) {
        $seconds -= $remain;
        $current = nextbizstart($ed);
        while ($seconds > $bizdaylength) {
            $current = nextbizstart($current);
            $seconds -= $bizdaylength;
        }
    }
    $current = $current.later(seconds => $seconds);
    return $current.yyyy-mm-dd ~ " " ~ substr($current.hh-mm-ss,0,5);
}

sub isbiz($tm) {
    if ($tm.day-of-week > 5) {
        return False;
    }
    if ($tm.hour < 9 || $tm.hour >= 18) {
        return False;
    }
    return True;
}

sub nextbizstart($tm0) {
    my $tm = $tm0.clone;
    while ($tm.day-of-week > 5) {
        $tm = $tm.later(days => 1).
               clone(hour => 9, minute => 0, second => 0);
    }
    if ($tm.hour < 9) {
        $tm = $tm.clone(hour => 9, minute => 0, second => 0);
    } else {
        while (True) {
            $tm = $tm.later(days => 1)
                   .clone(hour => 9, minute => 0, second => 0);
            if ($tm.day-of-week <= 5) {
                last;
            }
        }
    }
    return $tm;
}

sub nextbizend($tm0) {
    my $tm = $tm0.clone;
    while ($tm.day-of-week > 5) {
        $tm = $tm.later(days => 1)
               .clone(hour => 18, minute => 0, second => 0);
    }
    if ($tm.hour >= 18) {
        while (True) {
            $tm = $tm.later(days => 1)
                   .clone(hour => 18, minute => 0, second => 0);
            if ($tm.day-of-week <= 5) {
                last;
            }
        }
    } else {
        $tm = $tm.clone(hour => 18, minute => 0, second => 0);
    }
    return $tm;
}
