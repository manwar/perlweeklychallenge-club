#!/usr/bin/env perl

#real	0m7.760s
#user	0m7.744s
#sys	0m0.004s



for my $i (0 .. 3_000_000) { 
	($i == &get_poly($i)) && print "$i\n"; 
}

#print &get_poly(518);

sub get_poly {
#-- for base-10 integer abc.. return a^1+b^2+c^3...
	my ($n)=@_;
	my (@nstr)=split(//,$n);
	my @indx = 1..@nstr;
	my $retval=0;
	for my $i (0..(@nstr-1)) {
	    $retval += ($nstr[$i] ** $indx[$i]);
  	}
  	return $retval;
}




