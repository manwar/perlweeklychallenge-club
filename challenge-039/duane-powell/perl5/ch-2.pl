#!/usr/bin/perl
use warnings;
use strict;
use feature qw( say );

# Problem: Write a script to demonstrate Reverse Polish notation(RPN). 
# Checkout the wiki page, https://en.wikipedia.org/wiki/Reverse_Polish_notation for more information about RPN.

# Solution: Simply port the psudo code on the wiki to Perl!

my @expression = qw(15 7 1 1 + - / 3 * 2 1 1 + + -);
my $expression = join(' ',@expression);

my @stack;
my $result = 0;
foreach my $token (@expression) {
	if ($token =~ m/\+|\-|\*|\//) { # is an operator
		my $op2 = pop @stack;
		my $op1 = pop @stack;
		my $result = eval "$op2 $token $op1";
		push @stack, $result;
	}
	else { # is a operand
		push @stack, $token;
	}
}
$result = pop @stack;
say "The result of $expression is $result";

__END__

The result of 15 7 1 1 + - / 3 * 2 1 1 + + - is 5

