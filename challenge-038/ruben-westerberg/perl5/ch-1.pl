#!/usr/bin/env perl
use strict;
use warnings;

my $d= qr(@{[join "|", map { sprintf "%02d", $_} 1..31]});
my $m= qr(@{[join "|", map { sprintf "%02d", $_} 1..12]});

for (@ARGV) {
	if (/(1|2)([0-9]{2})($m)($d)/) {
		print "Input $_ OK\n";
		print(join("-",($1==1?"20$2":"19$2",$3,$4)),"\n");
		next;
	}
	print "Input $_ invalid\n";
}
