#!/usr/bin/env perl

#real	0m0.480s
#user	0m1.139s
#sys	0m0.055s

#-- PDL solution using inline PP

use PDL;
use PDL::NiceSlice;
use PDL::AutoLoader;

use Inline 'Pdlpp';


#-- now find the sequence by checking ints up to 3_000_000

my $pdl=sequence(long, 3_000_000);
my $out= $pdl->get_poly;
print $pdl->where($pdl==$out),"\n";

#[0 1 2 3 4 5 6 7 8 9 89 135 175 518 598 1306 1676 2427 2646798]

__END__

__Pdlpp__

pp_addhdr('
#include "math.h"
');


#-- the below code used ideas from Laurent Rosenfeld's C solution
#-- https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-174/laurent-rosenfeld/c/ch-1.c

pp_def('get_poly',
	Pars => 'a(); [o]b()',
	Code => q{
		int mya = $a();
		int mya_length = ( (mya <= 9) ? 1 : (floor(log10($a()))+1) );
		$b()=0;
		while (mya > 0) {
			$b()+= pow(mya % 10, mya_length);
			mya /= 10;
			mya_length--;
		}
	}
);

