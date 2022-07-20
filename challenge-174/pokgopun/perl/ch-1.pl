use strict;
use warnings;

my $cntdwn = 19;
my $i = 0;
{
	print "$i\n" if isDisarium($i) && $cntdwn--;
	$i++;
	redo if $cntdwn && $i < 5_000_000;
}

sub isDisarium{
	### both sum and power retain their odd/even properties, we can use them to filter
	return $i % 2 == sum(digit($i)) % 2 ? $i==sum(power(digit($i))) : 0;
}
### take 1st argument as a number and return an array of digits made from it
sub digit{
	### use regex is faster
	return split //, shift;
#	my $n = shift;
#	{
#		unshift @_, $n % 10;
#		$n = int($n/10);
#		redo if $n;
#	}
#	return @_;
}
### takes all arguments as numbers and return summation of them
sub sum{
	my $sum;
	$sum += $_ foreach @_;
	return $sum
}
### take all arguments as numbers to power them to their orders and return them
sub power{
	foreach my $i (1..@_) {
		$_[$i-1] **= $i;
	}
	return @_;
}
