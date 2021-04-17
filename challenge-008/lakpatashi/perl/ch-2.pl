#!/usr/bin/perl

use warnings;
use strict;

# part 2
print "\n\n";
use POSIX;
use List::Util qw (max);
my @arr = ("This", "is", "a test of the", "center function");
my $n = max map {length $_}@arr;
print centreAlign($_, $n)."\n" for @arr;

sub centreAlign{
	my ($str,$n) = @_;	
	my $m = ceil $n/2;
	my $spaces = $m - mid($str);
	return ' 'x$spaces.$str;
}

sub mid{
	my ($str)= @_;
	return ceil (length $str)/2;
}
