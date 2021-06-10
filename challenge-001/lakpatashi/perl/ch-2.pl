#!/usr/bin/perl

use strict;
use warnings;
use feature "switch";

for my $i (1..20){
	given($i){
		when(not $i%15){
			print "fizzbuzz\n";
		}
		when(not $i%3){
			print "fizz\n";
		}
		when(not $i%5){
			print "buzz\n";
		}
		default{
			print "$i\n";
		}
	}
}
