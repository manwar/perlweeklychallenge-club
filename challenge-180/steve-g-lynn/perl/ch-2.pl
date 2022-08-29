#!/usr/bin/env perl

use PDL;
use PDL::NiceSlice;
use PDL::AutoLoader;

print trim(3,(1,4,2,3,5)),"\n"; #[4 3 5]
print trim(4,(9,0,6,2,3,8,5)),"\n"; #[9 6 8 5] 

sub trim {
	my ($i,@n)=@_;
	my $n = pdl @n;
	return $n->where($n >= $i);
}

