#!/usr/bin/env perl

use v5.38;
use Test::More;

my @examples = (
    { in => 1, out => ["UD"] },
    { in => 2, out => ["UDUD","UUDD"] },
    { in => 3, out => ["UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD"] },
    { in => 0, out => [""] },
    { in => 4, out => ["UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD",
                       "UDUUUDDD", "UUDDUDUD", "UUDDUUDD", "UUDUDDUD",
                       "UUDUDUDD", "UUDUUDDD", "UUUDDDUD", "UUUDDUDD",
                       "UUUDUDDD", "UUUUDDDD"] },
);

is_deeply [ dyck_words($_->{in}) ], $_->{out} foreach @examples;

done_testing;

sub dyck_words($n, $u = 0, $d = 0, $path = '') {
    return $path if $u == $n && $d == $n;
    return (
        ($d < $u ? dyck_words($n, $u, $d + 1, $path . 'D') : ()),
        ($u < $n ? dyck_words($n, $u + 1, $d, $path . 'U') : ())
    );
}
