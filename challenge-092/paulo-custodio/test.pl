#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl perl/ch-1.pl abc xyz"), "1\n";
is capture("perl perl/ch-1.pl abb xyy"), "1\n";
is capture("perl perl/ch-1.pl sum add"), "0\n";

is capture("perl perl/ch-2.pl 1,4 8,10 2,6"),       "(1,6), (8,10)\n";
is capture("perl perl/ch-2.pl 1,2 3,7 8,10 5,8"),   "(1,2), (3,10)\n";
is capture("perl perl/ch-2.pl 1,5 7,9 10,11"),      "(1,5), (7,9), (10,11)\n";

done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
