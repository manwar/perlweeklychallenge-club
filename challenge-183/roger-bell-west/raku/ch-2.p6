#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(datedifference('2019-02-10', '2022-11-01'), [3, 264], 'example 1');
is-deeply(datedifference('2020-09-15', '2022-03-29'), [1, 195], 'example 2');

sub datedifference($d1s, $d2s) {
    $d1s ~~ /(<[0..9]>+)\D(<[0..9]>+)\D(<[0..9]>+)/;
    my $d1 = Date.new(year => $0,
                      month => $1,
                      day => $2);
    $d2s ~~ /(<[0..9]>+)\D(<[0..9]>+)\D(<[0..9]>+)/;
    my $d2 = Date.new(year => $0,
                      month => $1,
                      day => $2);
    if ($d1 > $d2) {
        ($d2, $d1) = ($d1, $d2);
    }
    my $yd = $d2.year - $d1.year;
    my $inter = Date.new(year => $d2.year,
                         month => $d1.month,
                         day => $d1.day);
    if ($d1.month > $d2.month ||
        ($d1.month == $d2.month && $d1.day > $d2.day)) {
        $inter = Date.new(year => $d2.year-1,
                          month => $d1.month,
                          day => $d1.day);
        $yd--;
    }
    return [$yd, $d2-$inter];
}
