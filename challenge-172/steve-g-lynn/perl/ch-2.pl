#!/usr/bin/perl

#real	0m0.373s
#user	0m0.343s
#sys	0m0.025s


use PDL;
use PDL::NiceSlice;
use PDL::AutoLoader;

my $test = random(989_251); 
print &five_stats($test), "\n";

#-- for a large sample from a uniform distribution over [0,1] as with
#-- the PDL random generator, the quantiles are asymptotically equal to
#-- themselves, e.g., 75th percentile tends to 0.75 etc. 

#[
# [7.6412842e-07]
# [   0.25091544]
# [   0.50103764]
# [   0.75056426]
# [   0.99999814]
#]

sub five_stats {
	my ($x)= pdl @_;
	my $len = $x->dim(0);
	my $xindx = qsorti($x);
	my ($min, $quartile_1, $median, $quartile_3, $max);
	
	#-- quartiles
	#-- len divisible by 4, take midpoint of 1/4*len or 3/4+len
	#--- and next obs
	
	if ( ($len % 4) == 0) {
		$quartile_1 = 0.5*( $x($xindx( $len/4 )) +
			$x($xindx( $len/4 + 1 )) );						
			
		$quartile_3 = 0.5*( $x($xindx( 3*$len/4 )) +
			$x($xindx( 3*$len/4 + 1 )) );
	} else {
		$quartile_1 = $x($xindx (int($len/4)+1) );
		
		$quartile_3 = $x($xindx (int(3*$len/4)+1) );
	}

	#-- median
	#-- len divisible by 2, take midpoint of 1/2*len and next obs

	if ( ($len % 2) == 0) {
		$median = 0.5*( $x($xindx( $len/2 )) +
				$x($xindx( $len/2+1 )));
	} else {
		$median = $x($xindx ($len/2 +1));
	}
	
	$min = $x($xindx(0));
	$max = $x($xindx(-1));
	
	return pdl ([$min, $quartile_1, $median, $quartile_3, $max]);
	
}


