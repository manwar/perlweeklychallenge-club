#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (my $line = <>) {
    say $line =~ /(.).?\g{1}|(.)(.).*\g{3}\g{2}/ ? "true" : "false"
}

__END__
