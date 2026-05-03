#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 371-1,
written by Robbie Hatley on Sat May 2, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 371-1: Missing Letter
Submitted by: Reinier Maliepaard
You are given a sequence of 5 lowercase letters, with one letter
replaced by ‘?’. Each letter maps to its position in the alphabet
(‘a = 1’, ‘b = 2’, …, ‘z = 26’). The sequence follows a repeating
pattern of step sizes between consecutive letters. The pattern is
either a constant step (e.g., ‘+2, +2, +2, +2’) or a simple
alternating pattern of two distinct steps (e.g., ‘+2, +3, +2, +3’).

Example inputs:     ("ac?gi", "ad?jm", "ae?mq", "acf?k", "beg?l")
Expected outputs:       e        g        i         h        j

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Specifying alternating intervals which may-or-may-not be the same is the same as specifying one "even-index"
interval and one "odd-index" interval which may-or-may-not be the same. So we need only find-and-record the
first even-index interval, then find-and-record the first odd-index interval, then note the index of the ?
mark, then add the appreciate interval to the value of the index immediately before the ? to get our final
answer.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one-or more arguments which must
be space-separated single-quoted strings, with each string each containing 4 unique lower-case English letters
and one question mark, in proper Perl syntax, like so:

./ch-1.pl 'rat?v' 'zy?wv' 'agej?' '?egjl'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   use List::Util qw( uniq );

   # Find the missing letter:
   sub missing_letter ( $x ) {
      # Return "?" as error code if input is malformed:
      my $n = length $x;
      my @m;
      return '?' if 5 != $n;
      return '?' if $x !~ m/^[a-z?]{5}$/;
      return '?' if 1 != scalar (@m = $x =~ m/\?/g);
      return '?' if 4 != scalar (@m = $x =~ m/[a-z]/g);
      return '?' if 5 != scalar (uniq sort {$a cmp $b} split //, $x);
      # Find first even-index interval:
      my $feii;
      for ( my $i = 0 ; $i <= $n-2 ; $i += 2 ) {
         next if '?' eq substr $x,  $i,  1;
         next if '?' eq substr $x, $i+1, 1;
         $feii = ord(substr($x, $i+1, 1)) - ord(substr($x, $i, 1));
         last}
      # Find first  odd-index interval:
      my $foii;
      for ( my $i = 1 ; $i <= $n-2 ; $i += 2 ) {
         next if '?' eq substr $x,  $i,  1;
         next if '?' eq substr $x, $i+1, 1;
         $foii = ord(substr($x, $i+1, 1)) - ord(substr($x, $i, 1));
         last}
      # Determine missing letter:
      my $missing_letter;
      for ( my $i = 0 ; $i <= $n-1 ; ++$i ) {
         next if '?' ne substr $x, $i, 1;
         if ( 0 == $i ) {
            $missing_letter = chr(ord(substr($x,$i+1,1))-$feii)}
         elsif ( 0 == $i%2 ) {
            $missing_letter = chr(ord(substr($x,$i-1,1))+$foii)}
         else {
            $missing_letter = chr(ord(substr($x,$i-1,1))+$feii)}
         last}
      return $missing_letter}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? @ARGV : ("ac?gi", "ad?jm", "ae?mq", "acf?k", "beg?l");
#          Expected outputs :     e        g        i         h        j

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $s (@strings) {
   say '';
   my $m = missing_letter($s);
   say "String = \"$s\". Missing letter = \"$m\".";
}
