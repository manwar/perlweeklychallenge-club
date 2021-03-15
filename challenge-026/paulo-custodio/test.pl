#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl perl/ch-1.pl chancellor chocolate"), "8\n";

is capture("perl perl/ch-2.pl 0 90"), "45\n";
is capture("perl perl/ch-2.pl 0 45 90"), "45\n";

done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
