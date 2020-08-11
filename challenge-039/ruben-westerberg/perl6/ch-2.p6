#!/usr/bin/env perl6
#
my $expression=@*ARGS[0]//"15 7 1 1 + - / 3 * 2 1 1 + + -";
my @stack;
$expression ~~ s:g/\s+/ /;
put "Input expression: $expression";
for $expression.comb: /\S+/ {
	die "Error in input expression" if ! /^<[\-\+]>?\d+(\.\d+)*$/ && !/^<[\+\-\*\/]>$/;
	when $_ eq "+" {
		push(@stack, pop(@stack)+ pop(@stack));
	}
	when $_  eq "-" {
		push(@stack, pop(@stack)-pop(@stack));
	}
	when $_ eq "*" {
	push(@stack, pop(@stack)*pop(@stack));
	}
	when $_ eq "/" {
		push(@stack, pop(@stack)/pop(@stack));
	}
	default {
		push @stack, $_;
	}
}
put "Result: @stack[]";
