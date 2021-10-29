#!/usr/bin/env perl

# TASK #1 > Happy Women Day
# Submitted by: Mohammad S Anwar
# Write a script to print the Venus Symbol, international gender symbol for
# women. Please feel free to use any character.

# Output brainfuck program

use Modern::Perl;

my $text = <<'END';
    ^^^^^
   ^     ^
  ^       ^
 ^         ^
 ^         ^
 ^         ^
 ^         ^
 ^         ^
  ^       ^
   ^     ^
    ^^^^^
      ^
      ^
      ^
    ^^^^^
      ^
      ^
END

for (split //, $text) {
    print "[-]";            # zero cell
    print "+" x ord($_);    # set cell to ASCII value of character
    print ".";              # output character
}
print "\n";
