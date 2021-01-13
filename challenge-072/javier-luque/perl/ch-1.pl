#!/usr/bin/perl
# Test: ./ch-1.pl
use Modern::Perl;

my $N = shift // 20;
die ("N needs to be greated than 1 ")
	unless ($N > 10);

my ($factorial, $zeros) = processN($N);
say "$zeros as $N! = $factorial has $zeros trailing zeroes";

sub processN {
	my $N = shift;
	my $factorial = 1;
	my $zeroes = 0;

	# Calculate factorial
	for (my $i = 2; $i <= $N; $i++) {
		$factorial *= $i;
	}

	# Find zeroes
	for (my $i = 5; int($N / $i) >= 1; $i *= 5) {
		$zeroes += int($N / $i);
	}

	return $factorial, $zeroes;
}
