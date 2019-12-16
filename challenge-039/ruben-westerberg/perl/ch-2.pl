#!/usr/bin/env perl

my $expression=$ARGV[0]//"15 7 1 1 + - / 3 * 2 1 1 + + -";
my @stack;
$expression=~s/ +/ /g;
print "Input expression: $expression\n";
for (split " ", $expression) {
	die "Error in input expression" if !/[\-+]?\d+(\.\d+)*/ && !/[+\-*\/]/;
	for ($_) {
		if ($_ eq "+") {
			push @stack, pop(@stack)+ pop(@stack);
			last;
		}
		if ($_ eq "-") {
			push @stack, pop(@stack)-pop(@stack);
			last;
		}
		if ($_ eq "*") {
			push @stack, pop(@stack)*pop(@stack);
			last;
		}
		if ($_ eq "/") {
			push @stack, pop(@stack)/pop(@stack);
			last;
		}
		push @stack, $_;

	}
}
print "Result: @stack\n";
