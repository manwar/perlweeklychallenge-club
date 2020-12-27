#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl perl/ch-1.pl 000123"), "123\n";
is capture("perl perl/ch-1.pl 123"), 	"123\n";

is capture("perl perl/ch-2.pl 0"), 		"0\n";
is capture("perl perl/ch-2.pl 1"), 		"1\n";
is capture("perl perl/ch-2.pl 10"),		"A\n";
is capture("perl perl/ch-2.pl 34"),		"Y\n";
is capture("perl perl/ch-2.pl 35"),		"10\n";
is capture("perl perl/ch-2.pl -- -35"),	"-10\n";

is capture("perl perl/ch-2.pl -r 0"), 		"0\n";
is capture("perl perl/ch-2.pl -r 1"), 		"1\n";
is capture("perl perl/ch-2.pl -r A"),		"10\n";
is capture("perl perl/ch-2.pl -r Y"),		"34\n";
is capture("perl perl/ch-2.pl -r 10"),		"35\n";
is capture("perl perl/ch-2.pl -r -- -10"),	"-35\n";

done_testing;

sub capture {
	my($cmd) = @_;
	my $out = `$cmd`;
	$out =~ s/[ \t\v\f\r]*\n/\n/g;
	return $out;
}
