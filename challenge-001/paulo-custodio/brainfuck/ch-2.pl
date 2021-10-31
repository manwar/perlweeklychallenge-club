#!/usr/bin/env perl

# Challenge 001
#
# Challenge #2
# Write a one-liner to solve the FizzBuzz problem and print the numbers 1
# through 20. However, any number divisible by 3 should be replaced by the word
# ‘fizz’ and any divisible by 5 by the word ‘buzz’. Those numbers that are both
# divisible by 3 and 5 become ‘fizzbuzz’.

# Output brainfuck program

use Modern::Perl;

my $text = "";
for my $n (1..20) {
	if ($n%15==0) {
		$text .= "fizzbuzz\n";
	}
	elsif ($n%3==0) {
		$text .= "fizz\n";
	}
	elsif ($n%5==0) {
		$text .= "buzz\n";
	}
	else {
		$text .= "$n\n";
	}
}

for (split //, $text) {
    print "[-]";            # zero cell
    print "+" x ord($_);    # set cell to ASCII value of character
    print ".";              # output character
}
print "\n";
