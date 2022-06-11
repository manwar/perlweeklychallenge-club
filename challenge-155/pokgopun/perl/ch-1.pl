use strict;
use warnings;
use Math::Prime::Util qw/is_prime next_prime/;
use List::Util qw/uniqint/;
use bignum;

## Take an argument for number of Fortunate nubmers, default to 8 as asked by the challenge's task 
my $n = shift;
$n = 8 unless $n;
die "n has to be an integer\n" unless $n =~ /^\d+$/;

my $prime;
my @prime;
my @fortunate;
my $i = 0;
my $j = 0;
{
	{
		last if @prime > $i && @prime > $j;
		#printf "\@prime=%s, i=%s, j=%s\n", scalar(@prime), $i, $j;
		$prime = $prime ? next_prime($prime) : 2;
		push @prime, $prime;
	}
	my $pn = join(" * ",@prime[0..$j]);
	my $m = $prime[$i];
	#printf "test if %s + %s is a prime\n", $pn, $m;
	if ( is_prime(eval($pn) + $m) ){
		push @fortunate, $m; 
		@fortunate = uniqint sort{$a<=>$b} @fortunate;
		#printf "!!! Found fortunate number m: %s\n", $m;
		$j++;
		$i = 0;
	}else{ $i++; }
	redo if @fortunate < $n;
} 
printf "%s\n", join(", ",@fortunate);
