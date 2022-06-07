#!/usr/bin/perl

use Math::Prime::XS qw(is_prime);

local %saveprimes=();
for (0..150) {
	local $chk=&perrin($_);
	(is_prime($chk)) && ($saveprimes{$chk}=1);
	@saveprimes==26 && last;
}

print "( ";
foreach (sort{$a<=>$b} keys %saveprimes){
	print "$_ ";
}
print ")\n";

#-- subs


sub perrin {
	local ($n)=@_;
	
	if ($n==0) { return 3 }
	else { return &postmult_302(&matpow($n)) }
}

#-- subs for fast computation of perrin number using matrix formula
#-- see wikipedia https://en.wikipedia.org/wiki/Perrin_number

#-- [0 1 0; 0 0 1; 1 1 0]^n (only need 1st row)
sub matpow {
	local ($n)=@_;
	
	if ($n==1) { return (0,1,0) }
	else {return &postmult_010_001_110(&matpow($n-1))}
}


# 3x3 matrix * [0 1 0; 0 0 1; 1 1 0] (retain 1st row of product)
sub postmult_010_001_110 {
	# [a11 a12 a13; a21 a22 a23; a31 a32 a33]*[0 1 0; 0 0 1; 1 1 0]
	local ($a11,$a12,$a13)=@_; #just need 1st row
	
	local $b11=$a13;
	local $b12=$a11+$a13;
	local $b13=$a12;

	return ($b11,$b12,$b13) #-- return just 1st row
}

# 3x3 matrix * [3;0;2] retain 1st element of product
sub postmult_302 {
	local ($a11,$a12,$a13)=@_; #-- just need 1st row
	# [a11 a12 a13; a21 a22 a23; a31 a32 a33]*[3;0;2]
	#
	return $a11*3+$a13*2; #-- 1st element

}
