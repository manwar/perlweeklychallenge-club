#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl perl/ch-1.pl 1,2,3,4,9,10,14,15,16"), "1-4,9,10,14-16\n";

is capture("perl perl/ch-2.pl"), "262537412640768743.9999999999992500725971981856888793538563373316\n";

done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
