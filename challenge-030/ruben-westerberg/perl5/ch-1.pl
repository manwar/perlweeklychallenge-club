#!/usr/bin/env perl
use strict;
use warnings;
use Time::Piece;
use Time::Seconds;

 my $t=localtime(0)->add_months(11)->add_years(49)+24*ONE_DAY;
while ((2019 <= $t->year) && ($t->year <= 2100)) {
	print "$t\n" if $t->_wday==0;
	$t=$t->add_years(1);
}
