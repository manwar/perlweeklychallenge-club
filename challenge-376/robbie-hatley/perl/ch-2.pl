#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 376-2,
written by Robbie Hatley on Mon Jun 01, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 376-2: Doubled Words
Submitted by: Matt Martini
You are given a string (which may contain embedded newlines)
which is taken from a page on a website. The string will not
contain brackets qw{ [ ] }. Write a script that will find
doubled words (such as “this this”) and highlight (wrap in
brackets) each doubled word. The script should:
- Work across lines, even finding situations where a word at the
  end of one line is repeated at the beginning of the next.
- Find doubled words despite capitalization differences, such as
  with 'The the...', as well as allow differing amounts of
  whitespace (spaces, tabs, newlines, and the like) to lie
  between the words.
- Find doubled words even when separated by HTML tags. For example, to
  make a word bold: '...it is <B>very</B> very important...'.
- Only show lines containing doubled words.
Adapted from Mastering Regular Expressions, Third Edition,
by Jeffrey E. F. Friedl.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The bulk of this task can be done with a single regular expression.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one-or-more space-separated
arguments, which must be dollar-signed single-quoted strings, with all apostrophes quoted as '"'"', like so:

./ch-2.pl $'She danced a can can.' $'In regard to your proposition, no\nno no, that won'"'"'t do at all!'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;

   # Put brackets around doubled words:
   sub double_double_toil_and_trouble ( $s ) {
      $s = "\n" . $s . "\n";
      $s =~ s/(\b\p{L}+\b)((?:<[^>]*>)?\s*(?:<[^>]*>)?)(\1)/[${1}]${2}[${3}]/gis;
      $s =~ s/\n(?:[^\[\]]*)\n/\n/gs;
      $s =~ s/^\s+//;
      $s =~ s/\s+$//;
      $s;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? @ARGV :
(
   "you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing.",
   # Expected output: "web server for doubled words (such as '[this] [this]'), a common problem"
   "Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words.",
   # Expected output: "Find doubled words despite capitalization differences, such as with '[The]\n[the]...', as well as allow differing amounts of whitespace (spaces,"
   "to make a word bold: '...it is <B>very</B> very important...'.",
   # Expected output: "to make a word bold: '...it is <B>[very]</B> [very] important...'."
   "Perl officially stands for Practical Extraction and Report Language, except when it doesn't.",
   # Expected output: ""
   "There's more than one one way to do it.\nEasy things should be easy and hard things should be possible.",
   # Expected output: "There's more than [one] [one] way to do it."
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $string (@strings) {
   say '';
   say '';
   say "Original string:\n"
      ."\"$string\"";
   my $double = double_double_toil_and_trouble($string);
   say '';
   say "Bracketed string:\n"
      ."\"$double\"";
}
