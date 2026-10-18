#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (my $line = <>) {
    my ($r1, $i1, $r2, $i2) = $line =~ /-?[0-9]+/g;
    my $r  = $r1 * $r2 - $i1 * $i2;
    my $i  = $r1 * $i2 + $r2 * $i1;
    my $ft = $i < 0 ? "%d+(%d)i\n" : "%d+%di\n";
    printf $ft => $r, $i
}

__END__
