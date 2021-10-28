#!/usr/bin/env perl

# Challenge 001
#
# Challenge #1
# Write a script to replace the character ‘e’ with ‘E’ in the string
# ‘Perl Weekly Challenge’. Also print the number of times the character ‘e’
# is found in the string.

# Output brainfuck program

use Modern::Perl;

my $s = "Perl Weekly Challenge";
my $text = ($s =~ tr/e/E/)." ".$s;

for (split //, $text) {
    print "[-]";            # zero cell
    print "+" x ord($_);    # set cell to ASCII value of character
    print ".";              # output character
}
print "\n";
