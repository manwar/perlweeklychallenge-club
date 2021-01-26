#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl/ch-1.pl 12 18"), "(1, 2, 3, 6)\n";
is capture("perl/ch-1.pl 18 23"), "(1)\n";

is capture("perl/ch-2.pl XY  X   XXY"),     "1\n";
is capture("perl/ch-2.pl XY  Z   XYZ"),     "1\n";
is capture("perl/ch-2.pl XXY XXZ XXXXZY"),  "1\n";
is capture("perl/ch-2.pl YX  X   XXY"),     "0\n";

done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
