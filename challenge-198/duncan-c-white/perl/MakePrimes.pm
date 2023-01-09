#
#	mkprimes module (converted from mkprimes.c)
#

use strict;
use warnings;
use Function::Parameters;

my $debug = 0;
my @foundprimes;	# remember all primes we've found..


#
# my @primes = primes_upto( $n );
#	Find all primes up to N; return a list of all such primes
#	(note that 1 is not usually considered a prime)
#
fun primes_upto( $n )
{
	my @isprime;

	for( my $i=1; $i<=$n; $i++ )
	{
		$isprime[$i] = 1;		# initially
	}

	# now sieve the non-primes out..
	my $upper = int(sqrt($n));
	printf( "debug: n=%d, upper=%d\n", $n, $upper ) if $debug;
	for( my $i=2; $i<=$upper; $i++ )
	{
		if( $isprime[$i] )
		{
			#printf( "debug: crossing out multiples of %d\n", $i );
			for( my $j=$i*$i; $j<=$n; $j+=$i )
			{
				$isprime[$j] = 0;
			}
		}
	}

	# after sieving, extract the primes
	my @primes = grep { $isprime[$_] } 2..$n;

	# remember them
	@foundprimes = @primes;

	return @primes;
}


#
# my @moreprimes = more_primes( $n, $m );
#	Need more primes!  Have @foundprimes up to $n, but need
#	to sieve primes from $n+1..$m, so re-sieve, return
#	a list of all new primes (in the range $n+1..$m) that we find.
#
fun more_primes( $n, $m )
{
	my %isprime;

	print "finding more primes from ", $n+1, "..$m\n";

	for( my $i=$n+1; $i<=$m; $i++ )
	{
		$isprime{$i} = 1;	# pre-sieving
	}

	# now sieve the non-primes out..
	foreach my $prime (@foundprimes)
	{
		# find first multiple of $prime > $n
		my $mult = $prime * (int($n/$prime)+1);

		#print "debug: xo multiples of $prime from $mult to $m\n";

		for( my $j=$mult; $j<=$m; $j+=$prime )
		{
			delete $isprime{$j};
		}
	}

	# after sieving, extract the primes
	my @primes = grep { $isprime{$_} } $n+1..$m;
	push @foundprimes, @primes;
	return @primes;
}


1;
