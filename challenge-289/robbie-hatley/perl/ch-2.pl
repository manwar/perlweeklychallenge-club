#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 289-2,
written by Robbie Hatley on Mon Sep 30, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 289-2: "Jumbled Letters"
Submitted by: Ryan Thompson

An Internet legend dating back to at least 2001 goes something
like this:

Aoccdrnig to a rscheearch at Cmabrigde Uinervtisy, it deosn’t
mttaer in waht oredr the ltteers in a wrod are, the olny
iprmoetnt tihng is taht the frist and lsat ltteer be at the
rghit pclae. The rset can be a toatl mses and you can sitll raed
it wouthit porbelm. Tihs is bcuseae the huamn mnid deos not raed
ervey lteter by istlef, but the wrod as a wlohe.

This supposed Cambridge research is unfortunately an urban
legend. However, the effect has been studied. For example —
and with a title that probably made the journal’s editor a little
nervous — "Raeding wrods with jubmled lettres: there is a cost"
by Rayner, White, et. al. looked at reading speed and
comprehension of jumbled text.

Your task is to write a program that takes English text as its
input and outputs a jumbled version as follows:
The first and last letter of every word must stay the same.
The remaining letters in the word are scrambled in random order.
(if that happens to be the original order, that is OK).
Whitespace, punctuation, and capitalization must stay the same.
Word order does not change, only the letters inside the word.

So, for example, “Perl” could become “Prel”, or stay as “Perl,”
but it could not become “Pelr” or “lreP”.

I don’t know if this effect has been studied in other languages
besides English, but please consider sharing your results if you
try!

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The trick will be to determine where each "word" begins and ends. The regexp metasymbol "\b" should help with
this. Apostrophes will complicate things a bit, but I'll handle those in a second pass through the string.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via a single command-line argument, which must be a single-quoted string, with any apostrophes
escaped as '"'"', in proper Perl syntax, like so:
./ch-2.pl 'She shaved her legs, then she gobbled seven hotdogs, but she didn'"'"'t take a bath.'

Output is to STDOUT and will be a version of the input string with each word's inner letters scrambled.

Example #1:
./ch-2.pl 'She shaved her legs, then she gobbled seven hotdogs, but she didn'"'"'t take a bath.'
She shvaed her legs, tehn she gbobled sveen hogotds, but she dnid't take a btah.

Example #2:
./ch-2.pl 'A version of the input string with each word'"'"'s inner letters scrambled.'
A vsroein of the input srntig wtih ecah wrod's inner ltteres searclbmd.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.16;
use utf8;

# Scramble a cluster of characters:
sub scramble {
   my $input  = shift @_;
   my $output = '';
   while ($input) {
      my $ran_idx = int rand length $input;
      my $spliced = substr $input, $ran_idx, 1, '';
      $output .= $spliced;
   }
   $output;
}

# Jlmbue the "inenr" ltetrs of the wrdos of a srtnig:
sub jumble {
   # Get our string:
   my $string = shift @_;

   # First, jumble the inner letters of words with no apostrophe:
   $string =~ s/\b([A-Za-z])([a-z]+)([a-z])\b/$1.scramble($2).$3/eg;

   # Now, handle words with apostrophes:
   $string =~ s/\b([A-Za-z])([a-z]+)('[a-z]+)\b/$1.scramble($2).$3/eg;

   # Return our result:
   $string;
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
if (1 != scalar(@ARGV) ) {
   die qq(Error: Must have 1 argument, which must be a single-quoted sentence in\n)
      .qq(a language, such as English or French, which uses space-separated words.\n)
      .qq(Any apostrophes must be escaped as '"'"' .\n)
      .qq(Sample valid inputs:\n)
      .qq(./ch-2.pl 'She shaved her legs, then she gobbled seven hotdogs, but she didn'"'"'t take a bath.'\n)
      .qq(./ch-2.pl 'A version of the input string with each word'"'"'s inner letters scrambled.'\n);
}
my $string = $ARGV[0];

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
my $jumbled = jumble($string);
say "$jumbled";
