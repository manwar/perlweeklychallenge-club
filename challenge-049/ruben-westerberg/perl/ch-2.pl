#!/usr/bin/env perl

use strict;
use warnings;
no warnings 'experimental';
use Time::HiRes;
use v5.24;
my ($GET_CMD,$SET_CMD,$SYNC_CMD,$UPDATE_CMD,$DUMP_CMD)=0..4;


print "Inital backing store  contents:\n";
largeSlowStore($DUMP_CMD);

my $counter=0;

for (0..19) {
	print "\nOperation: $counter\n";
	fastSmallCache(int(rand($SET_CMD+1)),int(rand(20)), int(rand(100)));
	fastSmallCache($DUMP_CMD);
	print '=' x 20,"\n";
	$counter++;
}
print "Resulting backing store before flush/sync of lru cache\n";
largeSlowStore($DUMP_CMD);

fastSmallCache($SYNC_CMD);                                        
print "Resulting backing store after sync \n";
largeSlowStore($DUMP_CMD);                                        

sub fastSmallCache {
	my ($cmd,$index,$value)=@_;
	state $capacity=5;
	state %index;
	state @lru;
	do {
		given ($cmd) {
			when ($GET_CMD) {
				print "\nRead Cache: ";
				do {given ($index{$index}) {
						when (undef) {
							print "-Miss\n";
							#cache miss
							my $val=largeSlowStore($GET_CMD,$index);
							fastSmallCache($UPDATE_CMD,$index,$val) if  defined $val;
						}

						default {
							#cache hit
							print "-Hit\n";
							fastSmallCache($UPDATE_CMD,$index,$_);
						}
					}
				}

			}
			when ($SET_CMD) {
				print "\nWrite cache: \n";
				fastSmallCache($UPDATE_CMD,$index,$value);
			}
			when ($SYNC_CMD) {
				print "Syncing cache\n";
				largeSlowStore($SET_CMD,$_, $index{$_}) for (@lru);
				%index=();
				@lru=();
			}
			when ($UPDATE_CMD) {
				print "Updating cache: $index =>  $value\n";
				my ($k)=grep {$lru[$_] == $index} 0..@lru-1;
				my $tmp;
				$tmp=splice @lru,$k,1 if defined $k;
				#print "cached pre key: $tmp\n";
				my $del=shift @lru unless @lru < $capacity;
				if (defined $del) {
					print "Cache overflow\n";
					largeSlowStore($SET_CMD,$del,$index{$del});	
					delete $index{$del};
				}
				push @lru,$index;
				$index{$index}=$value;
			}
			when ($DUMP_CMD) {
				print "LRU keys: ", join ", ", @lru;
				print "\n\n";
			}
			
		}
	}
}



sub largeSlowStore {
	my ($cmd,$index,$value)=@_;
	state @data= map {int rand 10} 1..10; #initialize store 
	do {
		given ($cmd) {
			Time::HiRes::usleep 1000000 * rand 2;
			when ($GET_CMD) {
				print "Read backing store\n";
				$data[$index];
			};
			when ($SET_CMD) {
				print "Write backing store\n";
				$data[$index]=$value;
			}
			when ($DUMP_CMD) {
				print join ", ", map { defined $_? $_:"N/A"} @data;
				print "\n";
			}
		}
	}
}
