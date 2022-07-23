#!/usr/bin/env raku

#real	1m40.771s
#user	1m40.149s
#sys	0m0.150s

for (0..3_000_000) { say $_ if $_ == &get_poly($_) }

sub get_poly (Int $n) {
#-- for base-10 integer abc.. return a^1+b^2+c^3...
	my (@nstr)=$n.Str.split('');
	shift @nstr; pop @nstr;
	my @indx = 1..@nstr.elems;
	my $retval=0;
	for (0..(@nstr.elems-1)) -> $i {
	    $retval += (@nstr[$i] ** @indx[$i]);
  }
  return $retval;
}




