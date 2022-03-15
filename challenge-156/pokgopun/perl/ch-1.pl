use strict;
use warnings;
use Math::Prime::Util qw/is_prime/;

my $n = shift;
$n = 10 unless $n && $n =~ /^\d+$/;
my $i;
my %is_prime;
my @prime;
{
	my $j = ++$i;
	my $sum;
	{
		$sum += $j % 2;
		$j = int($j / 2);
		redo if $j;
	}
	if (defined $is_prime{$sum})
	{
		push @prime, $i if $is_prime{$sum};
	} else {
		$is_prime{$sum} = 0;
		if (is_prime($sum)){
			$is_prime{$sum} = 1;
			push @prime, $i
		}
	}
	redo if @prime < $n;
}
printf "%s\n", join(", ",@prime);
