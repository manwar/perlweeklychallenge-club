#!/usr/bin/perl

use warnings;
use strict;
use Data::Dumper;
use List::Util qw(sum);
use feature qw(switch);

#part 2
sub F{
	my $n = shift;
	return $n<=0? 1: $n - M(F($n-1));
}

sub M{
	my $n = shift;
	return $n<=0? 0: $n - F(M($n-1));
}

print "i\tF(i)\tM(i)\n";
for my $i (0..10){
	print $i,"\t",F($i),"\t",M($i),"\n";
}
