#!/usr/bin/raku

my %saveprimes=();
for ^Inf {
	my $chk=perrin($_);
	(is-prime($chk)) && (%saveprimes{$chk}=1);
	%saveprimes.elems==13 && last;
}

say %saveprimes.keys.sort({.Int});


#-- subs

multi sub perrin(0) {3} 
multi sub perrin(Int $n where ($n>0)){postmult_302(matpow($n))}

#-- subs for fast computation of perrin number using matrix formula
#-- see wikipedia https://en.wikipedia.org/wiki/Perrin_number

#[0 1 0; 0 0 1; 1 1 0]^n (retain 1st row)
multi sub matpow(1){ (0,1,0) }
multi sub matpow(Int $n where ($n>1)) { postmult_010_001_110 (matpow($n-1)) }

# 3x3 matrix * [0 1 0; 0 0 1; 1 1 0] (retain 1st row of product)
sub postmult_010_001_110 (*@inmatrix){
	# [a11 a12 a13; a21 a22 a23; a31 a32 a33]*[0 1 0; 0 0 1; 1 1 0]
	my ($a11,$a12,$a13)=@inmatrix; #just need 1st row
	
	my $b11=$a13;
	my $b12=$a11+$a13;
	my $b13=$a12;

	return ($b11,$b12,$b13) #-- return just 1st row
}

# 3x3 matrix * [3;0;2] retain 1st element of product
sub postmult_302 (*@inmatrix){
	my ($a11,$a12,$a13)=@inmatrix; #-- just need 1st row
	# [a11 a12 a13; a21 a22 a23; a31 a32 a33]*[3;0;2]
	#
	my $b1=$a11*3+$a13*2; #-- 1st element
	
	return $b1;
}
