#!/usr/bin/env perl

my $expression=$ARGV[0]//"2 3 + 10 * 10 - 4 /";
my @stack;
$expression=~s/ +/ /g;
print "Input expression: $expression\n";
for (split " ", $expression) {
	die "Error in input expression" if !/[\-+]?\d+(\.\d+)*/ && !/[+\-*\/]/;
	for ($_) {
		if ($_ eq "+") {
			my @opds=splice @stack,0,2;
			push @stack, @opds[0]+@opds[1];
			last;
		}
		if ($_ eq "-") {
			my @opds=splice @stack,0,2;
			push @stack, @opds[0]-@opds[1];
			last;
		}
		if ($_ eq "*") {
			my @opds=splice @stack,0,2;
			push @stack, @opds[0]*@opds[1];
			last;
		}
		if ($_ eq "/") {
			my @opds=splice @stack,0,2;
			push @stack, @opds[0]/@opds[1];
			last;
		}
		push @stack, $_;

	}
}
print "Result: @stack\n";
