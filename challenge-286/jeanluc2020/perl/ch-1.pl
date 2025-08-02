#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-286/#TASK1
#
# Task 1: Self Spammer
# ====================
#
# Write a program which outputs one word of its own script / source code at
# random. A word is anything between whitespace, including symbols.
#
## Example 1
##
## If the source code contains a line such as: 'open my $fh, "<", "ch-1.pl" or die;'
## then the program would output each of the words { open, my, $fh,, "<",, "ch-1.pl", or, die; }
## (along with other words in the source) with some positive probability.
#
## Example 2
##
## Technically 'print(" hello ");' is *not* an example program, because it does not
## assign positive probability to the other two words in the script.
## It will never display print(" or ");
#
## Example 3
##
## An empty script is one trivial solution, and here is another:
## echo "42" > ch-1.pl && perl -p -e '' ch-1.pl
#
############################################################
##
## discussion
##
############################################################
#
# We read the program code by opening $0 for reading, then reading everything
# line by line. We randomly select one line, which we then split into tokens
# at whitespace. Then we randomly select one token and print it.
# Obviously, this also contains comments, which we could exclude by grepping the
# program for lines that don't start in '#'.

use strict;
use warnings;

self_spammer($0);

sub self_spammer {
   my $program = shift;
   my @lines = ();
   open(my $IN, "<", $program) or die "Can't open $program for reading: $!";
   while(my $line = <$IN>) {
      chomp($line);
      push @lines, $line;
   }
   my $l = $lines[int(rand(1+$#lines))];
   my @tokens = split /\s+/, $l;
   my $t = $tokens[int(rand(1+$#tokens))];
   print "$t\n";
}

