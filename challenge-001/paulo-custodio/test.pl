#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl perl/ch-1.pl"), 		"5 PErl WEEkly ChallEngE\n";
is capture("gforth forth/ch-1.fs"), 	"5 PErl WEEkly ChallEngE\n";

my $expected = <<END;
1
2
fizz
4
buzz
fizz
7
8
fizz
buzz
11
fizz
13
14
fizzbuzz
16
17
fizz
19
buzz
END

is capture("perl perl/ch-2.pl"), $expected;
is capture("gforth forth/ch-2.fs"), $expected;


done_testing;

sub capture {
	my($cmd) = @_;
	my $out = `$cmd`;
	$out =~ s/[ \t\v\f\r]*\n/\n/g;
	return $out;
}
