use strict;
use warnings;
use Math::Prime::Util qw/is_prime factor gcd/;
#
# By its definition, 1st Achilles number is made of first two primes, their powers are greater than 1 but with gcd=1 
# => 2*2*2*3*3 = 72
my ($i,$count) = (72,0);
print($i) && $i++ && $count++;
{
	redo if is_prime $i && $i++;
	my %factor;
	$factor{$_}++ foreach factor $i;
	print ", $i" if keys(%factor) > 1 && !scalar(grep{$_ < 2} values %factor) && gcd(values %factor)==1 && $count++;
	$i++ && redo if $count < 20;
	print "\n";
}
