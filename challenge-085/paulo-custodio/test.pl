#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl/ch-1.pl 1.2 0.4 0.1 2.5"), "1\n";
is capture("perl/ch-1.pl 0.2 1.5 0.9 1.1"), "0\n";
is capture("perl/ch-1.pl 0.5 1.1 0.3 0.7"), "1\n";

is capture("perl/ch-2.pl   8"), "1\n";
is capture("perl/ch-2.pl  15"), "0\n";
is capture("perl/ch-2.pl 125"), "1\n";

done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
