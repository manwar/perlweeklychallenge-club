#!/usr/bin/perl
use strict;

# mmddyyyy

# 02299220 -> out of range of the years, 
# therefore we do not need to consider 29th Feb

# we count the mmdd and see whether its reverse is within 2000 to 2999
# For the days: 01,03-11,13-21,23-31 are exclusive
# only consider 02,12,22

my @dd = ("02", 12, 22);
my @ddr = (20, 21, 22);

# There are 3*12 = 36 Palindrome. Dates Each of different years.

my @mm;
for my $i (0..11) {
	if ($i <= 8) {
	       	$mm[$i] = "0"; $mm[$i] .=($i+1) ;
	} else {$mm[$i] = $i+1;}

}

my @temp;

foreach my $i (@mm) {
	$temp[$i] = scalar reverse $i;
}

@temp = sort {$a cmp $b} @temp;

for my $i (0..2) {
	for my $j (0..11) {
		my $ttemp = scalar reverse $temp[$j];
		print $ttemp.$dd[$i].$ddr[$i].$temp[$j]."\n";
	}
}


