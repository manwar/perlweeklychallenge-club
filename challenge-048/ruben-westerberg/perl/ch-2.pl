#!/usr/bin/env perl
use strict;
use warnings;
use Time::Piece;
use Time::Seconds;


my $s=Time::Piece->strptime("2000-01-01","%Y-%M-%D");

my $e=Time::Piece->strptime("2999-01-01","%Y-%M-%D");
my $d=$s;
while ($d < $e) {
	my $str= $d->strftime("%m%d%Y");
	print "Date is a palindrone: ".$d->strftime."\n" if ($str eq reverse $str );
	$d+=ONE_DAY;
}

