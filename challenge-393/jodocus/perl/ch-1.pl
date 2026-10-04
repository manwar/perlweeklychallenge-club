#!/usr/bin/perl
use warnings;
use strict;
use Getopt::Long;

# Task 1: Pythagoras Multiplied
# You are given a positive integer n. Find the number of all positive integer triplets (a, b, c)
# so that a^2 + b^2 = c^2 and a, b and c are integers <= n.

my $unique;
GetOptions( "unique" => \$unique );
my $n;
if (@ARGV) { $n = shift; } else {
	print "Enter a positive integer: ";
	$n = <STDIN>;
	chomp($n);
}
die "$n is not a positive integer!\n" unless ($n =~ /^\d+$/ and $n > 0);

my @solutions;
my $a; my $b; my $c; my $d; my $A; my $B; my $C;

for $c (1 .. $n) {
	$b = 1;
	while ($b < $c) {
		$a = 1;
		if ($unique) { $d = $b; } else { $d = $c; };
		while ($a < $d) {
			if ($a ** 2 + $b ** 2 == $c ** 2) {
				$A = $a ** 2;
				$B = $b ** 2;
				$C = $c ** 2;
				push(@solutions, "$a^2 + $b^2 = $c^2    \t/ $A + $B = $C") };
			$a++;
		}
		$b++;
	}
}

print "a^2 + b^2 = c^2 for a, b, c < $n:\n";
if (@solutions) {
	for (@solutions) { print "$_\n"; }
} else { print "There are no solutions!\n"; }
