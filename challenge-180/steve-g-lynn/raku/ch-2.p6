#!/usr/bin/env perl6

&trim(3,(1,4,2,3,5));   #(4 3 5)
&trim(4,(9,0,6,2,3,8,5)); #(9 6 8 5)


sub trim($i, @n) {
	@n.grep({$_ >= $i}).say;
}


