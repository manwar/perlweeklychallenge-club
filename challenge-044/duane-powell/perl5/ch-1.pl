#!/usr/bin/perl
use warnings;
use strict;
use feature qw( say );
use Math::BaseCalc;

# Challenge:
# Only 100, please.
# You are given a string 123456789. Write a script that would insert + or - in between digits so that when you evaluate,
# the result should be 100.

# Solution: There are nine digits and 3 symbols (+,-,null). There are 8 slots in which to 
# place the 3 symbols, 3**8 = 6561 combinations, times 9 numbers gives 59,049 combinations, 
# a trival number to rip thru looking a sum of 100

my $n   = shift || "123456789";
my $sum = shift || 100;

my @n = split(//,$n);
my %operator = (
	0 => '',
	1 => '+',
	2 => '-',
);

my $comb = 3 ** ((scalar @n) -1);  # 6561 combinations for 123456789
my $calc = new Math::BaseCalc(digits => [0,1,2]); 
foreach (0 .. $comb-1) { # zero indexed
	my @op = split(//,sprintf "%08d", $calc->to_base($_));
	my $e;
	# zipper together the two arrays (@n and @op) building str $e, for example 1+2+3+4+5+6+7+8+9 
	foreach my $n (@n) {
		if (scalar @op) {
			my $op = pop @op;
			$e .= $n . $operator{$op};
		}
		else {
			$e .= $n;
		}
	}
	my $s = eval $e;
	say "$e = $sum" if ( $s == $sum );
}

__END__

./ch-1.pl
123-45-67+89 = 100
12-3-4+5-6+7+89 = 100
12+3+4+5-6-7+89 = 100
123+4-5+67-89 = 100
1+2+3-4+5+6+78+9 = 100
12+3-4+5+67+8+9 = 100
1+23-4+56+7+8+9 = 100
1+2+34-5+67-8+9 = 100
1+23-4+5+6+78-9 = 100
123+45-67+8-9 = 100
123-4-5-6-7+8-9 = 100

./ch-1.pl 1234567 10
1-2-3-4+5+6+7 = 10
1+2+3-4-5+6+7 = 10
1+2-3+4+5-6+7 = 10
1-2+3+4+5+6-7 = 10
1-23+45-6-7 = 10
1+23+4-5-6-7 = 10

