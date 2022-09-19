use strict;
use warnings;
use feature 'say';
#use Data::Dumper;

my %isprime;		# values we've tested and found to be prime
my %tested;		# values we've tested - whether or not they're prime

$tested{1} = 1;
$isprime{1} = 0;

#
# my $isprime = isprime( $x );
#	Return 1 iff $x is prime.  Memoize the ones we know.
#
sub isprime ($)
{
	my( $x ) = @_;
	return $isprime{$x} if $tested{$x};

	$tested{$x}++;
	$isprime{$x} = 0;
	my $lim = int(sqrt($x));
	for( my $i=2; $i<=$lim; $i++ )
	{
		return 0 if $x % $i == 0;
	}
	$isprime{$x} = 1;
	return 1;
}


1;
