#!/usr/bin/env perl6
(2020..2099).map({
	my $t=Date.new(year=>$_,month=>12,day=>25);
	$t.day-of-week==7??$t!!|();
})>>.put;
