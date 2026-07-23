#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (my $line = <>) {
    $, = ' ';
    say glob $line =~ s/\?/{0,1}/gr;
}

__END__
