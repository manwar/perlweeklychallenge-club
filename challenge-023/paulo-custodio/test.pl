#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;
use Path::Tiny;

is capture("perl perl/ch-1.pl 1  5 9 2 8 1 6"), "4, -7, 6, -7, 5.\n";
is capture("perl perl/ch-1.pl 2  5 9 2 8 1 6"), "-11, 13, -13, 12.\n";
is capture("perl perl/ch-1.pl 1  4 -7 6 -7 5"), "-11, 13, -13, 12.\n";

is capture("perl perl/ch-2.pl 1"), "1.\n";
is capture("perl perl/ch-2.pl 2"), "2.\n";
is capture("perl perl/ch-2.pl 3"), "3.\n";
is capture("perl perl/ch-2.pl 4"), "2, 2.\n";
is capture("perl perl/ch-2.pl 5"), "5.\n";
is capture("perl perl/ch-2.pl 6"), "2, 3.\n";
is capture("perl perl/ch-2.pl 7"), "7.\n";
is capture("perl perl/ch-2.pl 8"), "2, 2, 2.\n";
is capture("perl perl/ch-2.pl 9"), "3, 3.\n";
is capture("perl perl/ch-2.pl 10"), "2, 5.\n";
is capture("perl perl/ch-2.pl 228"), "2, 2, 3, 19.\n";

done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
