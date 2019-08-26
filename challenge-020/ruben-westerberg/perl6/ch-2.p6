#!/usr/bin/env perl6
my ($n1,$n2);
for 1..* {
	$n2=proper(++$n1);
	my $n1test=proper($n2);
	next if $n2==$n1;
	last if $n1test==$n1;
}
sub proper(\n) {
	sum (1..n-1).grep({ n%%$_});
}
put "Smallest Amicable Numbers: ($n1, $n2)";
