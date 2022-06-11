use strict;
use warnings;

sub isPrime{
	my $n = shift;
	my $c = 2;
	return 1 if $n == $c;
	{
		return 0 if $n % $c++ == 0;
		redo unless $c > $n - 1;
	}
	return 1 
}

sub isPrimeX{
	my $n = shift;
	return $n > 1 if $n <= 3;
	return 0 if $n % 2 == 0 || $n % 3 == 0;
	my $i = 5;
	while ( $i**2 <= $n){
		return 0 if $n % $i == 0 || $n % ($i + 2) == 0;
		$i += 6;
	}
	return 1;
}

#my $n = shift;
#printf "$n is%sa prime number\n", isPrimeX($n) ? " " : " not ";
#exit(0);

my $last = 1;
my $count_prime = 0;
my @last = qw/1 1 1/;
my $output = "";
{
	push @last, $last[1] + $last[0];
	my $p = $last[-1];
	shift @last;
	{
		#last;
		last if $p == $last;
		$last = $p;
		last unless isPrimeX($p);
		#printf "Padovan Prime #%s is %s\n", ++$count_prime, $p;
		$count_prime++;
		$output .= $p.", ";

	}
	redo if $count_prime  < 10;
	#print "$p\n";
	#redo unless $p == 3093215881333057;
}
$output =~ s/\D+$//;
printf "%s\n", $output;

