#! /usr/bin/raku

use Test;

plan 2;

is(bankingdayoffset('2018-06-28', 3, ['2018-07-03']), '2018-07-04', 'example 1');
is(bankingdayoffset('2018-06-28', 3, []), '2018-07-03', 'example 2');

sub parsedate($s) {
    $s ~~ /(<[0..9]>+)\D(<[0..9]>+)\D(<[0..9]>+)/;
    return Date.new($0, $1, $2);
}

sub bankingdayoffset($start, $offset, @bankholidays) {
    my $bh = Set(@bankholidays.map({parsedate($_)}));
    my $current = parsedate($start);
    for (1 .. $offset) {
        $current = $current.later(days => 1);
        while ($bh{$current}:exists || $current.day-of-week > 5) {
            $current = $current.later(days => 1);
        }
    }
    return $current.yyyy-mm-dd;
}
