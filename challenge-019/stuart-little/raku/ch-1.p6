#!/usr/bin/env perl6
use v6;

for ((1900..2019) X (1..12))
.grep({ my $date=Date.new($_[0],$_[1],1);
	my @range=($date..$date.last-date-in-month);
	(5,6,7).map(-> $day { @range.grep({ $_.day-of-week==$day }).elems }).all == 5 }) {.say}

# run as <script>
