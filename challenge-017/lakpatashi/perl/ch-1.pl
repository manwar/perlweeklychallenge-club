#!/usr/bin/perl

use warnings;
use strict;
use Data::Dumper;
use List::Util qw(sum);
use feature qw(switch);

#part 1
sub A{
	my ($m,$n) = @_;
	if($m == 0){
		return $n+1
	}elsif($n == 0){
		return A($m-1,1);
	}else{
		return A($m-1, A($m, $n-1));
	}
}
print A(1,2);

#part 2
