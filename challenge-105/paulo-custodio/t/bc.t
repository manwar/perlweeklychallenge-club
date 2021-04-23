#!/usr/bin/perl

use strict;
use warnings;
use 5.030;
use Test::More;

is capture("echo 5 248832 | bc -lq ./bc/ch-1.bc"), "11.9999\n";
is capture("echo 5 34     | bc -lq ./bc/ch-1.bc"),  "2.0242\n";

done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    return $out =~ s/\r//gr;
}
