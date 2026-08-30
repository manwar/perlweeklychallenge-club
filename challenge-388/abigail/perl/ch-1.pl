#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

#
# Recursive generate the valid strings. If the number of "U"s ($u) and
# "D"s ($d) both equal the required length ($n), print it.
# If the number of "D"s is less than the number of "U"s, recurse with
# an added "D".
# If the number of "U"s is less than the required length, recurse with
# and added "U".
#
# Initially called with an empty prefix, so $u == $d == 0.
#

#
# Precondition: $n >= $u >= $d >= 0.
#
sub process ($n, $u = 0, $d = 0, $prefix = "") {
    print $prefix, " " if $d == $n;
    process ($n, $u, $d + 1, $prefix . "D") if $d < $u;
    process ($n, $u + 1, $d, $prefix . "U") if $u < $n;
}

while (my $n = <>) {
    process $n;
    print "\n";
}

__END__
