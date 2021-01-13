#!/usr/bin/perl
use strict;
use warnings;

sub is_prime {
	my $num = shift;
	return $num > 1 if $num <= 3;
	return if $num % 2 == 0 || $num % 3 == 0;

	my $ctr = 5;
	while ($ctr * $ctr <= $num) {
		return if $num % $ctr == 0
			|| $num % ($ctr + 2) == 0;
		$ctr += 6;
	}

	return $num;
}

sub get_perfect_numbers {
	my $to_get = shift;
	$to_get = 5 if !defined $to_get;

	my @perfect_numbers = ();
	my ($got_so_far, $ctr) = 0;
	while ($got_so_far < $to_get) {
		$ctr++;
		if (is_prime(2**$ctr - 1)) {
			push @perfect_numbers, 2**($ctr-1) * (2**$ctr - 1);
			$got_so_far++;
		}
	}

	return @perfect_numbers;
}

print join ",", get_perfect_numbers(5);

__END__
