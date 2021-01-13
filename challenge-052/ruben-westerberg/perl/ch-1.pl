#!/usr/bin/env perl
use strict;
use warnings;
use v5.26;
use List::Util;
my ($start, $end)=sort {$a > $b } ($ARGV[0]//100, $ARGV[1]//999);
#Check the numbers are withing range
die "Arguments are not in range\n" unless 2==grep { 100<=$_ and $_ <=999} ($start,$end);

for ($start..$end) {
	my $prev;
	my $val= grep {$_ == 1} map {
		#print "Number: $_\n";
		my @res;
		if (!defined($prev)) {
			@res=();
		}
		else { 
			@res=($_ - $prev);
		}
		$prev=$_;
		@res;
	 } split "",$_;
	 #print $val,"\n";;
	print "Stepping number: $_\n" if $val==length($_) - 1;
	#print "$_:  ",join(", ",@val),"\n";
}
