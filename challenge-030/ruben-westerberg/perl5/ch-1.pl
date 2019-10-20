#!/usr/bin/env perl
use strict;
use warnings;
use Time::Piece;
use Time::Seconds;

print map { $_->strftime("%Y-%m-%d\n") }map  {
	my $t=localtime(0)->add_months(11)->add_years($_-1970)+24*ONE_DAY;
	$t->_wday == 0? $t: ();	
 }
(2019..2100);
