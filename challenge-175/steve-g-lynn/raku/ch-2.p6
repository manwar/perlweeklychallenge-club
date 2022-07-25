#!/usr/bin/env raku

use Inline::Perl5;
use Math::Prime::Util:from<Perl5> <euler_phi>;

my $ctr=0;
for (2 .. 10_000) -> $i {
	if ($i == &iterated_totient($i)) {
		say $i;
		$ctr++;
	}
	last if ($ctr > 19);	
}


# referred to perl 5 code in https://oeis.org/A082897
sub iterated_totient ($n) {

	my $totient=euler_phi($n);

	return 1 if $totient == 1;

	return $totient + iterated_totient($totient); 
}
