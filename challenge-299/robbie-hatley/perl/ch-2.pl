#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 299-2,
written by Robbie Hatley on Fri Dec 13, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 299-2: Word Search
Submitted by: Mohammad Sajid Anwar
You are given a grid of characters and a string. Write a script
to determine whether the given string can be found in the given
grid of characters. You may start anywhere and take any
orthogonal path, but may not reuse a grid cell.

Example #1:
Input: @chars =
['A', 'B', 'D', 'E'],
['C', 'B', 'C', 'A'],
['B', 'A', 'A', 'D'],
['D', 'B', 'B', 'C'],
$str = 'BDCA'
Output: true

Example #2:
Input: @chars =
['A', 'A', 'B', 'B'],
['C', 'C', 'B', 'A'],
['C', 'A', 'A', 'A'],
['B', 'B', 'B', 'B'],
$str = 'ABAC'
Output: false

Example #3:
Input: @chars =
['B', 'A', 'B', 'A'],
['C', 'C', 'C', 'C'],
['A', 'B', 'A', 'B'],
['B', 'B', 'A', 'A'],
$str = 'CCCAA'
Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I made a subroutine which uses this approach: From each possible starting point, try building paths from that
point which obey these three restrictions:
1. Path doesn't go out-of-bounds
2. Path doesn't re-use any cells
3. Path so-far matches relevant characters of string
If any path is found which fully matches string, return 1; else return 0.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of matrix/string pairs, in proper Perl syntax, like so:
./ch-2.pl '([[["a","p","p","g"],["f","q","l","z"],["b","n","e","y"]], "apple"],
            [[["a","p","r","g"],["f","q","l","z"],["b","n","e","y"]], "apple"],)'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8;
   use List::Util qw( any );
   my $db = 0;

   # Can a path be formed in a given matrix matching a given string?
   sub word_search ($mref, $string, @path) {
      # Get the lengths of string and path:
      my $slen = length($string);
      my $plen = scalar(@path);
      # If string is empty, a zero-length path matches the zero-length string, so return 1:
      return 1 if 0 == $slen;
      # If we get to here, string is not empty.
      # If @path is empty, check paths using every cell as starting point:
      if ( 0 == scalar @path ) {
         for    ( my $i = 0 ; $i <= $#$mref         ; ++$i ) {
            for ( my $j = 0 ; $j <= $#{$mref->[$i]} ; ++$j ) {
               # Skip this cell if it doesn't match first letter of string:
               next if $mref->[$i]->[$j] ne substr($string,0,1);
               # If we get to here, string starts with this character, so see if we can make a match:
               return 1 if (word_search($mref, $string, ([$i,$j])));
            }
         }
         # If we get to here, we couldn't find a match at the highest recursive level, so return 0 to caller:
         return 0;
      } # end if (path is empty)
      # If we get to here, neither string nor path are empty.
      # If path is bigger than string, something bizarre has happened, so print warning and return 0:
      if ($plen > $slen) {
         warn "WARNING FROM WORD SEARCH SUBROUTINE: PATH BIGGER THAN STRING.\n";
         return 0;
      }
      # Else if path and string are same length, return 1 if they match, 0 if they don't:
      elsif ($plen == $slen) {
         # Make a test string consisting of the characters of @path:
         my $test = '';
         for my $cell (@path) {
            $test .= $mref->[$cell->[0]]->[$cell->[1]];
         }
         # If $test matches $string, return 1, else return 0:
         return($test eq $string);
      }
      # Else if path is shorter than string, try all possible next cells, but reject any next cells that are
      # out-of-bounds, or re-use cells of path, or don't match string:
      elsif ($plen < $slen) {
         # Make an array of 4 sets of cell coordinates, Right, Up, Left, and Down relative to current head:
         my @next =
         (
            [$path[-1]->[0]+1,$path[-1]->[1]+0], # Right
            [$path[-1]->[0]+0,$path[-1]->[1]+1], # Up
            [$path[-1]->[0]-1,$path[-1]->[1]+0], # Left
            [$path[-1]->[0]+0,$path[-1]->[1]-1], # Down
         );
         # For each of those possible "next" cells, if it's in-bounds and doesn't re-use cells from @path,
         # make a new path using the "next" cell as new head, and recurse this subroutine on the new path:
         for my $cell (@next) {
            my ($i,$j) = @$cell;
            # Skip this cell if it's outside the bounds of the matrix:
            next if $i < 0 || $i > $#$mref || $j < 0 || $j > $#{$mref->[$i]};
            # Skip this cell if it re-uses any of the cells of the given partial path:
            next if any {$i == $_->[0] && $j == $_->[1]} @path;
            # Skip this cell if it doesn't match relevant character of string:
            next if $mref->[$i]->[$j] ne substr($string, $plen, 1);
            # Make a new path with current cell as new head:
            my @new_path; push @new_path, @path; push @new_path, $cell;
            # Recurse on new path and return 1 if succesful:
            return 1 if word_search($mref, $string, @new_path);
         } # end for (each cell of @next)
         # If we get to here, we couldn't build a match from the given path, so return 0:
         return 0;
      } # end if (path length < string length)
   } # end sub word_search

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @pairs = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   [
      [
         ['A', 'B', 'D', 'E'],
         ['C', 'B', 'C', 'A'],
         ['B', 'A', 'A', 'D'],
         ['D', 'B', 'B', 'C'],
      ],
      'BDCA',
   ],
   # Expected output: true

   # Example #2 input:
   [
      [
         ['A', 'A', 'B', 'B'],
         ['C', 'C', 'B', 'A'],
         ['C', 'A', 'A', 'A'],
         ['B', 'B', 'B', 'B'],
      ],
      'ABAC',
   ],
   # Expected output: false

   # Example #3 input:
   [
      [
         ['B', 'A', 'B', 'A'],
         ['C', 'C', 'C', 'C'],
         ['A', 'B', 'A', 'B'],
         ['B', 'B', 'A', 'A'],
      ],
      'CCCAAA',
   ],
   # Expected output: true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $pref (@pairs) {
   say '';
   my $mref   = $pref->[0];
   my $string = $pref->[1];
   say 'Matrix =';
   say "[@$_]" for @$mref;
   say "String = $string";
   word_search($mref, $string)
   and say "Word search succeeded."
   or  say "Word search failed.";
}
