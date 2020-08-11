#!/usr/bin/perl
use Modern::Perl;
use Math::Prime::Util qw(is_prime);
use bigint;

# Create a script that prints Prime Decomposition of a given number. 
# The prime decomposition of a number is defined as a list of prime 
# numbers which when all multiplied together, are equal to that number. 
# For example, the Prime decomposition of 228 is 2,2,3,19 as 228 = 2 x 2 x 3 x 19.

my @num = @ARGV;
(@num) || die "Usage:\n$0 list-of-space-separted-ints;\n$0 test\n"; 
@num = (228,864,1008,1024,130321,823543,3894380348208432032,7102345678999999999) if ($ARGV[0] eq 'test');
prime_fact($_) foreach (@num);
exit;

sub prime_fact {
	my $p = shift;
	if ($p < 2 or $p =~ m/\D/) {
		say "$p? Input must be an integer greater than 1";
		return;
	} 

	my %out;
	my $fac = 2;	
	my $n = $p;
	while ($n >=2) {
		if (is_prime($n)) {
			$out{$n}++;
			last;
		} else {
			if ($n % $fac) {
				# Remainder exists, try next factor.
				$fac++;
			} else {
				# No remainder, $fac is a factor.
				# Continue with smaller $n
				$out{$fac}++;
				$n = $n/$fac;
			}
		}
	}

	# We got all factors and their counts, make the output human 
	# readable with commify() and powers, eg 2 x 2 x 2 = (2^3)
	my @out;
	foreach (sort {$a <=> $b} (keys %out)) {
		if ($out{$_} > 1) {
			push @out, "($_^" . commify($out{$_}) . ")";
		} else {
			push @out, commify($_);
		}
	}
	# If input $p was a prime then display output as p=1xp by unshifting 1 into front of @out
	unshift @out, 1 if (@out == 1 and $out[0] !~ m/\(/);
	$p = commify($p);
	say "$p = ", join(" x ", @out);
}

# From the Perl Cookbook
sub commify {
	my $n = reverse shift;
	$n =~ s/(\d\d\d)(?=\d)(?!\dx\.)/$1,/g;
	return scalar reverse $n;
}

__END__

./ch-2.pl 999999999
999,999,999 = (3^4) x 37 x 333,667

./ch-2.pl 256 500 1001
256 = (2^8)
500 = (2^2) x (5^3)
1,001 = 7 x 11 x 13

./ch-2.pl test
228 = (2^2) x 3 x 19
864 = (2^5) x (3^3)
1,008 = (2^4) x (3^2) x 7
1,024 = (2^10)
130,321 = (19^4)
823,543 = (7^7)
3,894,380,348,208,432,032 = (2^5) x 47 x 136,373 x 18,987,252,871
7,102,345,678,999,999,999 = 661 x 45,600,991 x 235,627,549

