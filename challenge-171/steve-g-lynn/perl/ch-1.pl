#!/usr/bin/perl

#time (bash):
#real	0m0.050s
#user	0m0.043s
#sys	0m0.006s

use Math::Factor::XS qw(factors);

#-- main
my @retval=(); #-- return value
for (my $n=1;; $n+=2) {
#-- loop over odd numbers only
	( &is_abundant($n) ) && (push @retval, $n); 
	last if scalar(@retval) > 19;
}
&printa(@retval); 

#-- subs
sub is_abundant {
#-- check if sum of factors > n
	my ($n) = @_;
	return  (&sum_factors($n) > $n);
}

sub sum_factors {
#-- sum over factors (excluding n itself)
	my ($n) = @_;
	return 1+&sum( factors ($n));
	#-- factors($n) does not include 1 which should be added
}


sub sum {
#-- sum over an array
	my $sum=0;
	return ( (map {$sum += $_} @_ ) [-1] );
}

sub printa {
#-- print an array
	foreach (@_) { print "$_ "}; print "\n";
} 
