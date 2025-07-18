#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 330-2,
written by Robbie Hatley on Thu Jul 17, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 330-2: Title Capital
Submitted by: Mohammad Sajid Anwar
You are given a string made up of one or more words separated by
a single space. Write a script to capitalize the given title. If
the word length is 1 or 2 then convert the word to lowercase,
otherwise make the first character uppercase and remaining
lowercase.

Example #1:
Input: $str = "PERL IS gREAT"
Output: "Perl is Great"

Example #2:
Input: $str = "THE weekly challenge"
Output: "The Weekly Challenge"

Example #3:
Input: $str = "YoU ARE A stAR"
Output: "You Are a Star"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll split the input on whitespace to an array, then I'll use a 3-part index loop to process each array
element, Title-Casing each array element with size >=3 and lower-casing the remainder. Exception: This
problem's description doesn't mention it, but the convention in English is to also Title-Case the first word
of every title, so I'll also do that.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:

./ch-2.pl '("tHe silMARillion", "a TAle oF TwO cItIes", "proGRAMming pErL")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Correctly case a title:
   sub title ($t) {
      my @words = split /\s+/, $t;
      my $n = scalar(@words);
      for ( my $idx = 0 ; $idx < $n ; ++$idx ) {
         if ( 0 == $idx || length($words[$idx]) >= 3 ) {
            $words[$idx] =~ s/^(.)(.*)$/uc($1).lc($2)/e}
         else {
            $words[$idx] = lc $words[$idx]}}
      return join ' ', @words}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) : ("PERL IS gREAT", "THE weekly challenge", "YoU ARE A stAR");
#                   Expected outputs : ("Perl is Great", "The Weekly Challenge", "You Are a Star")

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $string (@strings) {
   say '';
   say "String = \"$string\"";
   my $title = title($string);
   say "Title  = \"$title\"";
}
