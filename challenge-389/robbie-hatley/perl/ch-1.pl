#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 389-1,
written by Robbie Hatley on Tue Sep 01, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 389-1: Reorder Notes
Submitted by: Reinier Maliepaard
You are given an array [composer, notes, permutation].
Reconstruct the melody by using each permutation value as the
destination position of the corresponding note. Use no explicit
for, foreach, or while loops. Output each result as
"COMPOSER => reordered notes". ASSUMPTION: Input is valid; the
notes array and permutation array have identical lengths, and
the permutation contains each position from 1 to N exactly once.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

I solved this by assigning the original array to an initially-empty array "sliced" by the permutation numbers.
(Slicing the original array won't work, because the permutation numbers indicate the destination indices, not
the source indices.)

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is either from default data or from @ARGV. If using @ARGV, provide one-or-more space-separated
single-quoted arguments. Each argument must contain 3 comma-separated substrings. The first substring
must be a composer's name. The second substring must be a space-separated sequence of notes. The third
substring must be a space-separated sequence of position numbers. For example:

./ch-1.pl 'Hovhaness, C F A B, 4 1 2 3' 'Bach, C E F, 3 7 5' 'Ligeti, Bb G# D Eb, 3 1 2 4'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   no warnings 'qw';
   use List::Util 'all';

   # Parse an argument:
   sub parse_arg ( $arg ) {
      my @parts = map {s/^\s+//;s/\s+$//;$_} split /,/, $arg;
      3 == scalar(@parts)
      or return ('*ERROR*', [], []);
      my $composer  =               $parts[0];
      my $melody    = [split /\s+/, $parts[1]];
      my $positions = [split /\s+/, $parts[2]];
      my @sorted    = sort {$a<=>$b} @$positions;
      scalar(@$melody) == scalar(@$positions)
      and all {/^[A-G][#b]?$/ } @$melody
      and all {/^[1-9][0-9]*$/} @$positions
      and all {$sorted[$_-1] == $_} @sorted
      or return ('*ERROR*', [], []);
      return ($composer, $melody, $positions);
   }

   # Rearrange a melody:
   sub rearrange ( $composer, $melody, $positions ) {
      my @rearranged;
      @rearranged[map {$_-1} @$positions] = @$melody;
      return uc($composer).' => '.join(' ', @rearranged);
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:

my @args = @ARGV ? @ARGV :
(
   'Bach, C D E F# G A B, 7 1 6 2 5 3 4',              # D F# A B G E C
   'Beethoven, C D F# G Ab, 1 3 5 2 4',                # C G D Ab F#
   'Brahms, C Db Eb F G Ab Bb C D, 9 3 7 1 8 5 2 6 4', # F Bb Db D Ab C Eb G C
   'Bruckner, G F# Bb C D Eb F, 4 7 2 6 1 5 3',        # D Bb F G Eb C F#
   'Berg, C#, 1',                                      # C#
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

map {
   say '';
   say "Input  : $_";
   my ($composer, $melody, $positions) = parse_arg($_);
   $composer eq '*ERROR*' and warn "Error  : Invalid input.\n"
   or say 'Output : ', rearrange($composer, $melody, $positions);
} @args
