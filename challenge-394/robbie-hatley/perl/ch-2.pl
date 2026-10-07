#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 394-2,
written by Robbie Hatley on Mon Oct 05, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 394-2: Alternating Vowels Consonants
Submitted by: Mohammad Sajid Anwar
You are given three strings containing English alphabetic
characters. Find all the longest contiguous substrings common to
all three strings that strictly alternate between vowels and
consonants.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

I'll make a hash of alternating substrings keyed by substring with value [occurrences_bitmask,length],
double-sort descending by occurrences_bitmask then length, then return sorted list of longest ones.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
arguments. Each argument must be a comma-separated triplet of strings of English letters. For example:

./ch-2.pl 'cucumber,encumber,cumbersome' 'carborgat,borgatcar,gatcarbor' 'rat,car,tap' ',,'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.40;
   $"=', ';

   # Return longest alternating V/C substrings in-common between 3 strings:
   sub longest ( $aref ) {
      my @longest;
      my %alts;
      # Record all alternating substrings in %alts:
      STRING:     for ( my $i =  0 ; $i < 3                  ; ++$i ) {
         START:   for ( my $j =  0 ; $j < length $aref->[$i] ; ++$j ) {
            STOP: for ( my $k = $j ; $k < length $aref->[$i] ; ++$k ) {
               # Get substring of string $i which begins at $j and ends at $k:
               my $s = substr($aref->[$i],$j,$k-$j+1);
               # Consider single-character strings to be "alternating":
               if ($j == $k) {
                  $alts{$s}->[0] |= 2**$i; # bits = 3rd str, 2nd str, 1st str
                  $alts{$s}->[1] = 1;      # length of substring
                  next STOP;
               }
               # Jump to next START if current char is same type as prev:
               my $tp = (substr($aref->[$i],$k-1,1) =~ m/^[aeiouAEIOU]$/) ? 'V' : 'C';
               my $tc = (substr($aref->[$i],$k-0,1) =~ m/^[aeiouAEIOU]$/) ? 'V' : 'C';
               next START unless $tp ne $tc;
               # This is an alternating V/C substring, so record it in %alts:
               $alts{$s}->[0] |= 2**$i;  # bits = 3rd str, 2nd str, 1st str
               $alts{$s}->[1] = $k-$j+1; # length of substring
            }
         }
      }
      # Return longest alternating V/C substrings in-common between 3 strings:
      my @skeys = sort {
         $alts{$b}->[0] <=> $alts{$a}->[0] || $alts{$b}->[1] <=> $alts{$a}->[1]
      } keys %alts;
      for ( my $i = 0 ; $i <= $#skeys ; ++$i ) {
         last if 7 != $alts{$skeys[$i]}->[0]; # 7 = 0b100 | 0b010 | 0b001
         last if $i > 0 && $alts{$skeys[$i]}->[1] != $alts{$skeys[$i-1]}->[1];
         push @longest, $skeys[$i];
      }
      return sort @longest;
   }

   # Is a given array of strings valid?
   sub is_valid ( $aref ) {
      return false if 'ARRAY' ne reftype $aref;
      return false if 3 != scalar @$aref;
      foreach my $item (@$aref) {
         return false if $item !~ m/^[A-Za-z]*$/;
      }
      true;
   }

   # Parse lists of strings:
   sub parse_argv_1 ( @bash_args ) {
      my @args = ();
      foreach my $bash_arg (@bash_args) {
         push @args, [map {trim $_} split /,/, $bash_arg, -1];
      }
      return @args;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? parse_argv_1(@ARGV) :
(
   [qw( relocate delocate allocate )],         # ("locate")
   [qw( apple banana cherry )],                # ()
   [qw( navigate cavity gravity )],            # ("avi")
   [qw( pedalgia pedalboard pedantic )],       # ("peda")
   [qw( schoolmaster schoolhouse schooling )], # ("ho", "ol")
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my @quoted_s = map {'"'.$_.'"'} @$aref;
   say "Strings = (@quoted_s)";
   if (!is_valid($aref)) {
      say STDERR "Error: Input must be 3 strings consisting of English letters only.";
      next;
   }
   my @l = longest($aref);
   my @quoted_l = map {'"'.$_.'"'} @l;
   say "Longest common alternating vowel/consonant substrings = (@quoted_l)";
}
