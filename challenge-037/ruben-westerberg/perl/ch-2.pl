#!/usr/bin/env perl
use strict;
use warnings;

use HTTP::Tiny;

print "Downloading November Data...\n";
my $res=HTTP::Tiny->new->get("https://www.timeanddate.com/sun/uk/london?month=11&year=2019");
my $nov=$$res{content};

print "Downloading December Data...\n";
$res=HTTP::Tiny->new->get("https://www.timeanddate.com/sun/uk/london?month=12&year=2019");
my $dec= $$res{content};

my $delta=extractDaylight($dec)- extractDaylight($nov);
my $sign= $delta>=0?"+":"-"; $delta=abs($delta);
my $hours=int($delta / 3600); $delta-=$hours*3600;
my $mins=int ($delta/60); $delta-=$mins*60;

print "December gained $sign$hours:$mins:$delta (H:M:S) compared to November\n";


sub extractDaylight {
	my $text=shift;
	my $total;
	while ($text=~ /<td class="c tr sep-l"(?:.*?)>(.+?)<\/td>/g) {
		my ($h,$m,$s)=split ":",$1;
		$total+=$h*3600+$m*60+$s;	
	}
	$total;
}
	
