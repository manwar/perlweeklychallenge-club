#!/usr/bin/env raku

use Test;

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

sub dyck-words($n, $u = 0, $d = 0, $path = '') {
    return ($path) if $u == $n && $d == $n;
    return (
        ($d < $u ?? dyck-words($n, $u, $d + 1, $path ~ 'D') !! ()),
        ($u < $n ?? dyck-words($n, $u + 1, $d, $path ~ 'U') !! ())
    ).flat;
}

is-deeply dyck-words($_<in>).List, $_<out>.List for @examples;

done-testing;
