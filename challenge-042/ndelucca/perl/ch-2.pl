#!/usr/bin/perl

# TASK #2
# Balanced Brackets

# Write a script to generate a string with random number of ( and ) brackets. Then make the script validate the string if it has balanced brackets.

# For example:
# () - OK
# (()) - OK
# )( - NOT OK
# ())() - NOT OK

use strict;
use warnings;

# We get random length for the string, but we leave it to the user to explore a fixed length
my $range = shift @ARGV || rand(24);

# String Length
my $len = rand($range);

# String Generator
my $lisp = '';
$lisp .= rand() < 0.5 ? '(' : ')' for 0 .. $len;

print "Generated: $lisp\n";

my $paired_matches = $lisp =~ s/\(\)//g;
$paired_matches = $lisp =~ s/\(\)//g while $paired_matches;

print "Un-paired brackets: $lisp\n";
print length ($lisp) > 0 ? "It's NOT balanced\n" : "It's balanced!\n";

# Turns out it's very difficult to get balanced strings
# I used 2 and 4 for demonstration

# $ perl ch-2.pl 2
# Generated: ()
# Un-paired brackets:
# It's balanced!

# $ perl ch-2.pl 2
# Generated: )(
# Un-paired brackets: )(
# It's NOT balanced

# $ perl ch-2.pl 4
# Generated: ()()
# Un-paired brackets:
# It's balanced!

# $ perl ch-2.pl 4
# Generated: (((
# Un-paired brackets: (((
# It's NOT balanced

# $ perl ch-2.pl 4
# Generated: (()
# Un-paired brackets: (
# It's NOT balanced

# $ perl ch-2.pl 4
# Generated: ))((
# Un-paired brackets: ))((
# It's NOT balanced

# $ perl ch-2.pl 4
# Generated: ))()
# Un-paired brackets: ))
# It's NOT balanced

# $ perl ch-2.pl 4
# Generated: (())
# Un-paired brackets:
# It's balanced!


