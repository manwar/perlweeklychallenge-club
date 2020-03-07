#!/usr/bin/perl
use strict;

# look like these things could be simplified 
# but this is my attempt on the LRU cache
my $capacity = $ARGV[0];

my @cacheprevious = ( -1 .. $capacity-1);
my @cachecoming = (1..$capacity, -1);    #doubly-linked list
my %cachehash;   #cache item as key, position as value

# Requirements:
# space O(n); get least recently used item O(1); access item O(1);
# ref: https://www.interviewcake.com/concept/java/lru-cache


# Usage:
# set $a_new_item if it hasn't existed on cache, return nothing, else return error message; 
# get $wanted_item, return -1 if not exists, else return the position;

my $L = 0;   # initial state of the cache (completely unused)
my $tailposition = 0;
my $headposition = 0;
my $hot;    # a variable for handling the most recent used data
my $dreamofuser;

sub check {            #subroutine for maintenance
	print "number of items:" , $L, "\n";
	my $key, my $value;
	while ( ($key, $value) = each %cachehash) {  #code from Learning Perl
		print "$key => $value\n";
	}

	print "\n";
}

sub max {
	$_[0]>$_[1] ? $_[0] : $_[1] ;
}

sub min {
	$_[0]<$_[1] ? $_[0] : $_[1] ;
}


#start of subroutine laundry
sub laundry { if ( ($cachehash{$hot} != $L-1) and ($headposition != $cachehash{$hot}) ) {

	my $tL = min( $cachehash{$hot} , $L-1);
	my %www = reverse %cachehash;

	my $g = 0;
	while ( defined($www{$g}) ) { $g++; }
	
	for (($g+1)..$tL+1) {
		$www{$_-1} = $www{$_};
		$cacheprevious[ $_-1 ] = $cacheprevious[ $_];
		$cachecoming[ $_-1 ] = $cachecoming[ $_ ];
	}

	delete $www{$tL+1};
	$tailposition = $tL;
	%cachehash = reverse %www;
}

if ($cacheprevious[$cachehash{$hot}] == -1) {
	my %www = reverse %cachehash;
	for (1..$L) {
		$www{$_-1} = $www{$_};
		$cacheprevious[ $_-1 ] = $cacheprevious[ $_];
		$cachecoming[ $_-1 ] = $cachecoming[ $_ ];
	};
	delete $www{$L};
	$tailposition = $L-1;
	%cachehash = reverse %www;
}

} #end of subroutine laundry





sub set {
	$hot = $_[0];
	if ($L < $capacity) {
	 	#the subroutine laundry makes sure when $L==$capacity, $cachecoming[$L-1] = -1; 
		$L++;
		$cachehash{$_[0]} = $L-1;

		if ($L == 1) {
			$cacheprevious[$cachehash{$_[0]}] = -1} else {
			$cacheprevious[$cachehash{$_[0]}] = $tailposition;
		}
		$tailposition = $L-1 ;
		$cachecoming[$cachehash{$_[0]}] = -1;
	} else { 
		# cache is full, get rid of the least recently used element
		foreach (keys %cachehash) {
			if ( $cachehash{$_} == 0) {
				$headposition = $cachecoming[$headposition]; 
				delete $cachehash{$_};
			} else {
				my $v = --$cachehash{$_};
				$cacheprevious[$v]--;
				$cachecoming[$v]--;
			}
		}
		$cachecoming[$tailposition] = $L-1;
		$cachehash{$_[0]} = $L-1;
		$cachecoming[$L-1] = -1;
		$cacheprevious[$L-1] = $tailposition-1;
		$tailposition = $L-1;
	}

	return "";

}

sub get {
	if (defined($cachehash{$_[0]})) {
		if ($cachehash{$_[0]} == $tailposition) {
			return $cachehash{$_[0]};
		} else {
			my $dreamofuser = $cachehash{$_[0]};
			if ($dreamofuser != 0) {
				$cachecoming[$cacheprevious[$dreamofuser]] = $cachecoming[$dreamofuser]; 
				$cacheprevious[$cachecoming[$dreamofuser]] = $cacheprevious[$dreamofuser];
			} else {$cacheprevious[$cachecoming[$dreamofuser]] = -1;}
	
			$cachehash{$_[0]} = $tailposition+1;
			$cacheprevious[$cachehash{$_[0]}] = $tailposition;
			$tailposition++;
			$cachecoming[$cachehash{$_[0]}] = -1;
			$hot = $_[0];
			return $dreamofuser;
		}
	} else {
		return -1;
	}
}

my $order;

# 0-indexed
# assumed distinct inputs

do {
	chomp($order = <STDIN>);
	if ($order =~ /^get\s([0-9]+)$/) {print(get($1), "\n"); &laundry;}
	if ($order =~ /^set\s([0-9]+)$/) {print(set($1), "\n"); }
} until ($order eq "")

