#!/usr/bin/env perl
use strict;
use warnings;

my @l;
while (@l<2) {
	print "Enter line".(@l+1).":  x1 y1 x2 y2\n";
	my $l=<STDIN>; my @p=split " ", $l;
	if (@p==4) {
		push @l, {px=>[@p[0,2]],py=>[@p[1,3]],m=>undef,c=>undef};
	}
	else {
		print "not a valid line! \n";
	}
}

for (@l) { $$_{c}=$$_{py}[0]-($$_{m}*$$_{px}[0]); }
my $x=($l[0]{c}-$l[1]{c})/( $l[1]{m}-$l[0]{m});
my $y=$l[0]{m}*$x+$l[0]{c};

print "Intercept point: $x, $y\n";
