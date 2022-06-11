use strict;
use warnings;
use Math::Prime::Util qw/is_prime/;

my $n = shift;
$n = 10 unless $n && $n =~ /^\d+$/;
my $i;
my @pn;
{
	my $j = ++$i;
	my $sum;
	{
		$sum += $j % 2;
		$j = int($j / 2);
		redo if $j;
	}
	push @pn, $i if is_prime($sum);
	redo if @pn < $n;
}
printf "%s\n", join(", ",@pn);
