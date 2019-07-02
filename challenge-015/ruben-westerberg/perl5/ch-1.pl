#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw<sum>;
use v5.24;

my (@week, @balanced, @strong); #Store the results here
my @p=\(@week,@balanced,@strong); #Make indexable
my @ps;	#Primes shift reg
my $i=0;

while ((@strong < 10) || (@week < 10) ){
	push @ps, nextPrime(); 	#Push the next prime into the shift reg
	next if $i++ <2;	#This line for priming buffer
	push @{$p[($ps[1]<=>(sum(@ps[0,2])/2))+1]}, $ps[1];    #Do test
	shift @ps; 		#Remove the oldest prime from shift reg
}

print "Week:   ",join(", ",@week[0..9]),"\n";
print "Strong: ",join(", ",@strong[0..9]),"\n";


sub nextPrime {
        state $p=1;
	$p+=1 until isPrime( $p);
	$p++;
}

sub isPrime {
	my $t=shift;
	my $sum=0;
	for (1..(int $t/2)) {
		$sum++ if $t % $_ == 0;
		last if $sum >1;
	}
	$sum==1;
}
