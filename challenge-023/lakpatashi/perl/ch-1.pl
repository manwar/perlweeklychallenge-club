#!/usr/bin/perl

use warnings;
use strict;
use Data::Dumper;
use List::Util qw(max min sum);
use feature qw(switch);
use Memoize;
memoize qw (factorial );

#part 1
# commandline arg ==> order, arr
my ($order,@arr) = @ARGV;
if($#ARGV < 0){	#default values when @ARGV is absent
	@arr = (5, 9, 2, 8, 1, 6);
	$order = 1;
}
print "arr :: @arr\n";
print "order :: $order\n";
print "diff :: ";
for my $i (0..$#arr-$order){
	print nthDiff( reverse @arr[$i..$i+$order] )," ";
}
print "\n";

sub nthDiff{
	#arr
	my @arr = @_;
	@arr = map { (-1)**($_) * binomial($#arr,$_) * $arr[$_]} 0..$#arr;
	return sum @arr;
}

sub binomial{
	my ($n,$r) = @_;
	return int factorial($n) / ( factorial($r) * factorial($n-$r));
}

sub factorial{
	my ($n) = @_;
	return 1 if $n<1;
	return $n*factorial($n-1);
}
