#!/usr/bin/env perl6

my $target=200;
my @moves;
my $d=$target;
while $d != 1 {
	if $d %% 2 {
		@moves.push("Double");
		$d/=2;
	}
	else {
		@moves.push("Add 1");
		$d-=1;
	}

}
my $t=1;
printf "Start: \t\t%3d\n",$t;
for @moves.reverse {
	$t+=1 when /^A/;
	$t*=2 when /^D/;
	printf "Move:\t%s:\t%3d\n",$_, $t;
}
