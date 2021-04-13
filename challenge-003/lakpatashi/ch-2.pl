#!/usr/bin/perl

use strict;
use warnings;

#	PART 2
print "\n\n";
my $n;
if($#ARGV >= 0){
	$n = shift;
	die "<rows> must be at least 3\n" if $n<3;
	my $line = '1';	
	for my $i (reverse 0..$n-1){
		#print ' ' x $i, "$i\n";
		$line = PascalNext($line) if $i <$n-1;
		print ' ' x $i, $line,"\n";
	}
}else{
	print "Usage: ./ch-1.pl <row-no>\n";
}

sub PascalNext{
	my $line = shift;	#scalar string
	#print $line,"\n";
	my @arr = split ' ', $line;
	unshift @arr, 0;
	push @arr,0;

	my @newArr;
	for my $i (1..$#arr){
		push @newArr, $arr[$i-1] + $arr[$i];
	}
	return join " ",@newArr;
}
#print "\n var:: $n\n";
