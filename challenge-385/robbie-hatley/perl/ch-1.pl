#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 385-1,
written by Robbie Hatley on Wed Aug 5, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 385-1: Uncommon Words
Submitted by: Mohammad Sajid Anwar
You are given two sentences. Write a script to return a list of
all uncommon words. Order is not important.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Judging by the answers given to the examples, I see that the word "uncommon" is being used to mean
"used once only", not "not in-common between sentences". So I use a hash to keep track of total occurrences
of words, and I return only those words which occur exactly once.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is default inputs, redirect, or pipe. (This program does not accept interactive text typed from
a terminal, and it ignores all command-line arguments.)

In all cases, each line of input text must consist of a newline-terminated line of text consisting of
two tab-separated sentences.

Example using default data:
./ch-1.pl

Example using a redirect:
./ch-1.pl < my-input-file.txt

Example using a pipe:
echo -ne " dog apple orange \t apple cow dog \n " | ./ch-1.pl

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   $"=', ';

   # Find all uncommon words (if any) between two sentences:
   sub ucw ( $s1, $s2 ) {
      my @out;
      my @w1 = split /\s+/, $s1 =~ s/^\s+//r =~ s/\s+$//r;
      my @w2 = split /\s+/, $s2 =~ s/^\s+//r =~ s/\s+$//r;
      my %h;
      for (@w1) {++$h{$_}}
      for (@w2) {++$h{$_}}
      for (keys %h) {push @out, $_ if 1==$h{$_}}
      return @out;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:

my @lines;

if (-t STDIN) {
   @lines =
   (
      # Example #1 input:
      " apple banana apple     \t banana orange          \n",
      # Expected output:       ("orange")

      # Example #2 input:
      " cat dog                \t bird fish              \n",
      # Expected output:       ("cat", "dog", "bird", "fish")

      # Example #3 input:
      " the quick brown fox    \t the quick              \n",
      # Expected output:       ("brown", "fox")

      # Example #4 input:
      " hello                  \t hello                  \n",
      # Expected output:       ()

      # Example #5 input:
      " blue blue red          \t red green green yellow \n",
      # Expected output:       ("yellow")
   );
}
else {
   @lines = <STDIN>;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for (@lines) {
   chomp;
   say '';
   my ($s1, $s2) = split '\t', $_;
   say "Sentence 1 = \"$s1\".";
   say "Sentence 2 = \"$s2\".";
   my @uncommon_words = ucw($s1, $s2);
   my @uncommon_words_quoted = map {"\"".$_."\""} @uncommon_words;
   say "Uncommon words = (@uncommon_words_quoted)";
}
