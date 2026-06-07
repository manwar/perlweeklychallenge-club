#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (<>) {
    my ($f1, $r1, $f2, $r2) = /([a-h])([1-8]) ([a-h])([1-8])/ or die;
    say +((ord ($f1) % 2 == ord ($r1) % 2) xor
          (ord ($f2) % 2 == ord ($r2) % 2)) ? "false" : "true"
}

__END__
