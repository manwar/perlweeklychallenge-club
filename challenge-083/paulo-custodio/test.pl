#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl/ch-1.pl The Weekly Challenge"),                    "6\n";
is capture("perl/ch-1.pl The purpose of our lives is to be happy"), "23\n";


is capture("perl/ch-2.pl 3 10 8"),  "1\n";
is capture("perl/ch-2.pl 12 2 10"), "1\n";


done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
