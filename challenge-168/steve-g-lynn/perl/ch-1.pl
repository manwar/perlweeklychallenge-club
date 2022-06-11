#!/usr/bin/perl

use Math::Prime::XS qw(is_prime);

local %saveprimes=();
local @perrin=(3,0,2);
for (1..150) {
	local $chk=$perrin[0];
	push @perrin, $perrin[0]+$perrin[1];
	shift @perrin;
	(is_prime($chk)) && ($saveprimes{$chk}=1);
	@saveprimes==26 && last;
}

print "( ";
foreach (sort{$a<=>$b} keys %saveprimes){
	print "$_ ";
}
print ")\n";


