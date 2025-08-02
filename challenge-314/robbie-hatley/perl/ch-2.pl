#!/usr/bin/env -S perl -C63

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 314-2,
written by Robbie Hatley on Mon Mar 24, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 314-2: Sort Column
Submitted by: Mohammad Sajid Anwar
You are given a list of strings of same length. Write a script
to make each column sorted lexicographically by deleting any
non-sorted columns. Return the total columns deleted.

Example #1:
Input: @list = ("swpc", "tyad", "azbe")
Output: 2
swpc
tyad
azbe
Column 1: "s", "t", "a" => non sorted
Column 2: "w", "y", "z" => sorted
Column 3: "p", "a", "b" => non sorted
Column 4: "c", "d", "e" => sorted
Total columns to delete to make it sorted lexicographically: 2

Example #2:
Input: @list = ("cba", "daf", "ghi")
Output: 1

Example #3:
Input: @list = ("a", "b", "c")
Output: 0

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I could cheat and just return the number of columns necessary to be deleted, but that's NOT what the problem
description actually says; it says "make each column sorted lexicographically by DELETING any non-sorted
columns". So I'll actually do that. I'll make these 4 subroutines:
1. col($pref,$n)          (Return a column.)
2. del_col($pref,$n)      (Delete a column.)
3. is_srt(@list)          (Is a list sorted?)
4. del_unsrt_cols($pref)  (Delete unsorted columns.)

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of equal-length double-quoted strings, in proper Perl syntax, like so:
./ch-2.pl '(["SNMP", "HTTP", "SVGA"],["132","546","879"],["zxy","nqp","fdh"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8;
   use List::Util qw( min );

   # Return a column from a page:
   sub col ($pref,$n) {
      return map {substr $_, $n, 1} @$pref;
   }

   # Delete a column from a page:
   sub del_col ($pref,$n) {
      map {substr $_, $n, 1, ''} @$pref;
   }

   # Is a given list already-sorted?
   sub is_srt (@list) {
      my @srt = sort @list;
      map {return 0 unless $srt[$_] eq $list[$_]} (0..$#list);
      return 1;
   }

   # Delete all unsorted columns from a page:
   sub del_unsrt_cols ($pref) {
      my $cols = min map {length($pref->[$_])} (0..$#$pref);
      my $delcnt = 0;
      for ( my $col = 0 ; $col <= $cols ; ++$col ) {
         if ( !is_srt(col($pref, $col)) ) {
            del_col($pref, $col);
            ++$delcnt; # Increment deletion counter,
            --$cols;   # because we deleted a column,
            --$col;    # and remaining columns shifted left.
         }
      }
      return $delcnt;  # Return number of columns deleted.
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @pages = @ARGV ? eval($ARGV[0]) : (["swpc","tyad","azbe"],["cba","daf","ghi"],["a", "b", "c"]);
#                 Expected outputs :             2                    1                 0

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $pref (@pages) {
   say '';
   say 'Page of text:';
   say for @$pref;
   my $removed = del_unsrt_cols($pref);
   say 'Page with unsorted columns removed:';
   say for @$pref;
   say "Number of unsorted columns removed = $removed";
}
