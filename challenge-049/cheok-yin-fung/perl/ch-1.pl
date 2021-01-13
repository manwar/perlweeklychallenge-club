#!/usr/bin/perl
use strict;
# use Math::BigInt;  could be for fun

sub max {
	$_[0]>$_[1] ? $_[0] : $_[1];
}

my $N = $ARGV[0];
my $C = $N;
my $s = 0;
my $t = 0;

while ( $C % 2 == 0) {
	$C /= 2; $s++;
}

while ( $C % 5 == 0) {
	$C /= 5; $t++;
}

# N = 2^s * 5^t * C
# Result = 2^max(s,t) * 5^max(s,t) * C * something


my @D = (1);
my $k = ( ($C==1) ? -1 : 0);
my @key = ();

while ($k != -1 and @key == () ) {
	
	my $temp;
	$temp = (10*$D[2**($k-1)]) % $C;  # in simpler but slower terms, $temp = (10**$k) % $C;
	$D[2**($k)] = $temp;
	$k++;
	if ($k != 0 or $k != 1) {for ( 1 .. 2**($k-1)-1 ) {
	       	$D[2**($k-1) + $_] = ( $D[$_] + $temp) % $C ; 
	        if ($D[2**($k-1) + $_] == 0) {
			push @key, 2**($k-1) + $_;
	# We cannot simply write:  $key = 2**($k-1) + $_;   
	# because there could be more than one mulitples in 100...000 to 111..111, e.g. C=27;
		}	
	}
	}


}

@key = sort {$a <=> $b} @key;

if ($C != 1) {printf "%0b", $key[0];} else {print 1;}
print "0" x max($s,$t);
