#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-289/#TASK2
#
# Task 2: Jumbled Letters
# =======================
#
# An Internet legend dating back to at least 2001 goes something like this:
#
##    Aoccdrnig to a rscheearch at Cmabrigde Uinervtisy, it deosn’t mttaer in
##    waht oredr the ltteers in a wrod are, the olny iprmoetnt tihng is taht
##    the frist and lsat ltteer be at the rghit pclae. The rset can be a toatl
##    mses and you can sitll raed it wouthit porbelm. Tihs is bcuseae the huamn
##    mnid deos not raed ervey lteter by istlef, but the wrod as a wlohe.
#
# This supposed Cambridge research is unfortunately an urban legend. However,
# the effect has been studied. For example—and with a title that probably made
# the journal’s editor a little nervous—Raeding wrods with jubmled lettres:
# there is a cost by Rayner, White, et. al. looked at reading speed and
# comprehension of jumbled text.
#
# Your task is to write a program that takes English text as its input and
# outputs a jumbled version as follows:
#
# 1. The first and last letter of every word must stay the same
# 2. The remaining letters in the word are scrambled in a random order (if that
#     happens to be the original order, that is OK).
# 3. Whitespace, punctuation, and capitalization must stay the same
# 4. The order of words does not change, only the letters inside the word
#
# So, for example, “Perl” could become “Prel”, or stay as “Perl,” but it could
# not become “Pelr” or “lreP”.
#
# I don’t know if this effect has been studied in other languages besides
# English, but please consider sharing your results if you try!
#
############################################################
##
## discussion
##
############################################################
#
# We replace all words with a randomized version of it by splitting
# each word into its first character, the middle part and the last
# character, of which we shuffle the middle part. We use the shuffle
# function from List::Util to do the actual randomizing, so the actual
# work is running s///eg on the input (e allows to call a function on
# the matched parts), and the randomize() function simply splits the
# middle part into individual characters, randomizes them and joins
# them together again.

use strict;
use warnings;
use List::Util qw(shuffle);

jumbled_letters("Perl");
jumbled_letters("Banane");
jumbled_letters("Motoröl");
jumbled_letters("The weekly challenge");
jumbled_letters("This supposed Cambridge research is unfortunately an urban legend. However, the effect has been studied.");

sub jumbled_letters {
   my $text = shift;
   print "Input: $text\n";
   $text =~ s/\b(\w)(\w*)(\w)\b/randomize($1, $2, $3)/eg;
   print "Output: $text\n";
}

sub randomize {
   my ($x, $y, $z) = @_;
   return $x . join("", shuffle(split//, $y)) . $z;
}

