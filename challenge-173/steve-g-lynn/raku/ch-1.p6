#!/usr/bin/env raku

say is_esthetic(5_456);   #True
say is_esthetic(120);	#False


sub is_esthetic ($number){
	$number ~~ s:g/_//; #-- get rid of thousands separators if any
	($number ~~ /^\d+$/) || (return False); #-- false if not a number
	for (0 .. ($number.chars-2)) -> $i {
		( (substr($number,$i+1,1)==(substr($number,$i,1)+1)) || 
		(substr($number,$i+1,1)==(substr($number,$i,1)-1)) ) ||
		return False;
	}
	return True; 
}
