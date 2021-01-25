#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl/ch-1.pl 5 2 -2 0"),    "1\n";
is capture("perl/ch-1.pl 1 8 -1"),      "2\n";
is capture("perl/ch-1.pl 2 0 -1"),      "1\n";
is capture("perl/ch-1.pl 3 2 1 0 -1"),  "4\n";


is capture("perl/ch-2.pl 1 2 2"),       "4\n";
is capture("perl/ch-2.pl 1 4 3 2"),     "7\n";


done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
