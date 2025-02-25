#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-305/#TASK2
#
# Task 2: Alien Dictionary
# ========================
#
# You are given a list of words and alien dictionary character order.
#
# Write a script to sort lexicographically the given list of words based on the
# alien dictionary characters.
#
## Example 1
##
## Input: @words = ("perl", "python", "raku")
##        @alien = qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/
## Output: ("raku", "python", "perl")
#
## Example 2
##
## Input: @words = ("the", "weekly", "challenge")
##        @alien = qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/
## Output: ("challenge", "the", "weekly")
#
############################################################
##
## discussion
##
############################################################
#
# We transliterate all words to their conjugate word in the transliterated
# namespace, then we can sort alphabetically. The we transliterate the sorted
# words back to the original words.

use strict;
use warnings;

alien_dictionary( ["perl", "python", "raku"], qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/ );
alien_dictionary( ["the", "weekly", "challenge"], qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/ );

sub alien_dictionary {
   my ($words, @alien) = @_;
   print "Input: (" . join(", ", @$words) . ")\n";
   print "       qw/" . join(" ", @alien) . "/\n";
   my $alien = join("",@alien);
   my @tmp = ();
   foreach my $w (@$words) {
      eval "\$w =~ tr/a-z/$alien/;";
      push @tmp, $w;
   }
   my @sorted = sort @tmp;
   @tmp = ();
   foreach my $w (@sorted) {
      eval "\$w =~ tr /$alien/a-z/;";
      push @tmp, $w;
   }
   print "Output: (" . join(", ", @tmp) . ")\n";
}
