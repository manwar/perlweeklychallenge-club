#!/usr/bin/perl
use warnings;
use strict;
use feature qw( say );
use Data::Dumper;

# Problem:  https://perlweeklychallenge.org/blog/perl-weekly-challenge-047/ TASK #1

my ($r1, $op, $r2) = @ARGV;
unless (scalar @ARGV == 3) {
	say "Usage: $0 Roman_numeral operator Roman_numeral";
	exit;
}

my %arabic = qw(
	I  1
	IV 4
	V  5
	IX 9
	X  10
	XL 40
	L  50
	XC 90
	C  100
	CD 400
	D  500
	CM 900
	M  1000
);
my %roman = reverse %arabic;

my $n = arabic($r1);
my $m = arabic($r2);
my $a = eval "$n $op $m";

my $r = roman($a);
say $r, " (", $a, ")";
exit;

sub arabic {
	my @roman = split(//, uc(shift));
	my ($arabic, $next, $error, $min) = (0, '', '', 1000);

	while (scalar @roman and not $error) {
		# Check for matching pair of Roman numerals, eg 'IV'
		if (scalar @roman > 1) {
			$next = $roman[0].$roman[1];
			if ( defined($arabic{$next}) ) {
				$arabic += $arabic{$next};
				$error = "Roman numeral out of sequence at $next" if ($arabic{$next} > $min); 
				$min = $arabic{$next};
				shift @roman;
				shift @roman;
				next;
	 		}				
		} 
		# Pair not found, maybe there is one matching numeral, eg 'I'
		if (scalar @roman > 0) {
			$next = $roman[0];
			if ( defined($arabic{$next}) ) {
				$arabic += $arabic{$next};
				$error = "Roman numeral out of sequence at $next" if ($arabic{$next} > $min); 
				$min = $arabic{$next};
				shift @roman;
				next;
	 		}				
			else {
				$error = "Invalid Roman numeral at $next";
			}
		}
	}

	if ($error) {
		say $error;
		exit;
	} 
	return $arabic;
}

sub roman {
	my $arabic = shift;
	$arabic = int($arabic);
	my $roman = '';
	while ($arabic > 0) {
		if ($arabic >= 1000) {
			$roman .= $roman{1000};
			$arabic -= 1000;
			next;
		}
		if ($arabic >= 900) {
			$roman .= $roman{900};
			$arabic -= 900;
			next;
		}
		if ($arabic >= 500) {
			$roman .= $roman{500};
			$arabic -= 500;
			next;
		}
		if ($arabic >= 400) {
			$roman .= $roman{400};
			$arabic -= 400;
			next;
		}
		if ($arabic >= 100) {
			$roman .= $roman{100};
			$arabic -= 100;
			next;
		}
		if ($arabic >= 90) {
			$roman .= $roman{90};
			$arabic -= 90;
			next;
		}
		if ($arabic >= 50) {
			$roman .= $roman{50};
			$arabic -= 50;
			next;
		}
		if ($arabic >= 40) {
			$roman .= $roman{40};
			$arabic -= 40;
			next;
		}
		if ($arabic >= 10) {
			$roman .= $roman{10};
			$arabic -= 10;
			next;
		}
		if ($arabic >= 9) {
			$roman .= $roman{9};
			$arabic -= 9;
			next;
		}
		if ($arabic >= 5) {
			$roman .= $roman{5};
			$arabic -= 5;
			next;
		}
		if ($arabic >= 4) {
			$roman .= $roman{4};
			$arabic -= 4;
			next;
		}
		if ($arabic >= 1) {
			$roman .= $roman{1};
			$arabic -= 1;
			next;
		}
	}
	return $roman;
}


__END__

./ch-1.pl
Usage: ./ch-1.pl Roman_numeral operator Roman_numeral

./ch-1.pl ICU + I
Invalid Roman numeral at U

./ch-1.pl ICM + I
Roman numeral out of sequence at CM

./ch-1.pl I + I
II (2)

./ch-1.pl V - I
IV (4)

/ch-1.pl M / L
XX (20)

./ch-1.pl XL + XL
LXXX (80)

./ch-1.pl X \* IX
XC (90)

./ch-1.pl M / V
CC (200)

./ch-1.pl M / X
C (100)

./ch-1.pl MCMXCV + IV
MCMXCIX (1999)

./ch-1.pl MCMXCV + XXV
MMXX (2020)

./ch-1.pl MMMM - I
MMMCMXCIX (3999)


