#!/usr/bin/env raku

say last-sunday(2022);


multi sub last-sunday(Int $year) {
	return (1 .. 12).map({last-sunday($year,$_)});
}

multi sub last-sunday(Int $year, Int $month) {
	my $d = Date.new($year,$month,20);
	return last-sunday($d);
}

multi sub last-sunday(Date $d) {
	return ($d .. $d.last-date-in-month).grep(*.day-of-week==7).tail;
}
