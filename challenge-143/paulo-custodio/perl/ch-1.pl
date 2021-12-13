#!/usr/bin/perl

# TASK #1 > Calculator
# Submitted by: Mohammad S Anwar
# You are given a string, $s, containing mathematical expression.
# 
# Write a script to print the result of the mathematical expression. To keep
# it simple, please only accept + - * ().
# 
# Example 1:
#     Input: $s = "10 + 20 - 5"
#     Output: 25
# Example 2:
#     Input: $s = "(10 + 20 - 5) * 2"
#     Output: 50

# Note: alternative one-liner solution: say eval("@ARGV")

use Modern::Perl;

# ($input, $value) = expr($input)
sub expr {
	my($input) = @_;
	($input, my $value) = factor($input);
	while (1) {
		if ($input =~ s/^\s*\*//) {
			($input, my $b) = factor($input);
			$value *= $b;
		}
		elsif ($input =~ s/^\s*\///) {
			($input, my $b) = factor($input);
			$value /= $b;
		}
		elsif ($input =~ /^\s*(?:\)|$)/) {
			return ($input, $value);
		}
		else {
			die "expected / or * at: $input\n";
		}
	}
}

# ($input, $value) = factor($input)
sub factor {
	my($input) = @_;
	($input, my $value) = term($input);
	while (1) {
		if ($input =~ s/^\s*\+//) {
			($input, my $b) = term($input);
			$value += $b;
		}
		elsif ($input =~ s/^\s*\-//) {
			($input, my $b) = term($input);
			$value -= $b;
		}
		else {
			return ($input, $value);
		}
	}
}

# ($input, $value) = term($input)
sub term {
	my($input) = @_;
	while (1) {
		if ($input =~ s/^\s*([-+]?\d+)//) {
			return ($input, $1);
		}
		elsif ($input =~ s/^\s*\(//) {
			($input, my $value) = expr($input);
			$input =~ s/^\s*\)// or die "expected ) at: $input\n";
			return ($input, $value);
		}
		else {
			die "expected ( or number at: $input\n";
		}
	}
}

my $input = "@ARGV";
($input, my $value) = expr($input);
say $value;
