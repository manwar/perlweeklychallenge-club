#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl perl/ch-1.pl 3"),  "4\n";
is capture("perl perl/ch-1.pl 4"),  "5\n";

is capture("perl perl/ch-2.pl 2 1 4 1 2 5"),    "6\n";
is capture("perl perl/ch-2.pl 3 1 3 1 1 5"),    "6\n";

done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
