#!/usr/bin/perl

use strict;
use warnings;

# PART 1
my $word = "abcde";
print "Given word: $word\n";
my @arr = split '', $word;
my $count=0;
for ( permutate(@arr) ){
	print join '',(@$_),"\n";
	$count++;
}
print "Total no. of words: $count\n";

sub permutate {
	return [@_] if @_ <= 1;
	map {
		my ($f, @r) = list_with_x_first($_, @_);
		map [$f, @$_], permutate(@r);
	} 0..$#_;
}

sub list_with_x_first {
	return if @_ == 1;
	my $i = shift;
	($_[$i], @_[0..$i-1], @_[$i+1..$#_]);
}

