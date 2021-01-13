#!/usr/bin/perl
#
# Task #2: "LRU Cache
#
# Write a script to demonstrate LRU Cache feature. It should support
# operations get and set. Accept the capacity of the LRU Cache as command
# line argument.
#
# Definition of LRU: An access to an item is defined as a get or a set
# operation of the item. "Least recently used" item is the one with the
# oldest access time.
#
# For example:
#
# capacity = 3
# set(1, 3)
# set(2, 5)
# set(3, 7)
#
# Cache at this point:
# [Least recently used] 1,2,3 [most recently used]
#
# get(2)      # returns 5
#
# Cache looks like now:
# [Least recently used] 1,3,2 [most recently used]
#
# get(1)      # returns 3
#
# Cache looks like now:
# [Least recently used] 3,2,1 [most recently used]
#
# get(4)      # returns -1
#
# Cache unchanged:
# [Least recently used] 3,2,1 [most recently used]
#
# set(4, 9)
#
# Cache is full, so pushes out key = 3:
# [Least recently used] 2,1,4 [most recently used]
#
# get(3)      # returns -1
#"
#
# My notes: ok, so an array of keys in most-recently-used
# order, and a hash to store the (no more than $capacity)
# key, value pairs.
# 

use feature 'say';
use strict;
use warnings;
use Function::Parameters;

die "Usage: ch-2 CAPACITY\n" unless @ARGV==1;
my $capacity = shift;

# represent the LRU cache as an array of keys in use order
# and a hash containing $capacity key,value pairs.

my @keysused;		# most recently used at front, last at end
my %cache;		# no more than $capacity key,value pairs

#
# my $result = get( $key );
#	If $key is present in the cache, promote $key to the most recently
#	used entry, and return the corresponding value from the cache;
#	or return -1 if $key is not present in the cache.
#
fun get( $key )
{
	return -1 unless exists $cache{$key};
	my $x = $cache{$key};
	@keysused = grep { $_ != $key } @keysused;
	unshift @keysused, $key;
	say "debug: keysused = ", join(',',@keysused);
	return $x;
}


#
# set( $key, $value );
#	Set $key to $value in the cache.  May need to remove another
#	key, value pair if the cache is at capacity and the key is NOT
#	already present.
#
fun set( $key, $value )
{
	@keysused = grep { $_ != $key } @keysused;
	unshift @keysused, $key;
	$cache{$key} = $value;
	if( @keysused > $capacity )
	{
		my $leastusedkey = pop @keysused;
		delete $cache{$leastusedkey};
	}
	say "debug: keysused = ", join(',',@keysused);
}


while( <STDIN> )
{
	chomp;
	# format: 'get x' or 'set x y'
	my @x = split(/\s+/);
	if( $x[0] eq "get" )
	{
		if( @x == 2 )
		{
			say "doing get($x[1])";
			my $result = get( $x[1] );
			say "get($x[1]): result $result";
		} else
		{
			warn "get needs one arg\n";
		}
	}
	elsif( $x[0] eq "set" )
	{
		if( @x == 3 )
		{
			say "doing set($x[1],$x[2])";
			set( $x[1], $x[2] );
		} else
		{
			warn "set needs two args\n";
		}
	}
}
