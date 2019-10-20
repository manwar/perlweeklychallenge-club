#!/usr/bin/env perl6
(2019..2100).map({
	my $t=Date.new(year=>$_,month=>12,day=>25);
	$t.day-of-week==7??$t!!|();
})>>.put;
