#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 396-1,
written by Robbie Hatley on Thu Oct 22, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 396-1: Finishing Order
Submitted by: Mohammad Sajid Anwar
You are given two array of integers, @order and @friends.
@order (size n) contains every integer from 1 to n exactly once.
@friends contains IDs in sorted in strictly increasing order.
Write a script to return the IDs in finishing order.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

To solve this problem, I use a hash %h with keys being the values of @order and values being
the corresponding indexes of @order. I then just sort @friends by {$h{$a}<=>$h{$b}}.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
arguments. Each argument must be a comma-separated sequence of two lists of positive integers. The first list
must be a permutation of its own 1-based indices. The second list must consist only of unique elements of the
first list, in strictly-increasing order.

For example, the first 3 inputs here will generate errors, but the 4th will be accepted:

./ch-1.pl '' 'cow dog pig,pig cow' '3 8 17 4 9,4 8 3' '1 3 5 2 4,2 3 5'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.40;
   $"=', ';

   # Sort finishers in finishing order:
   sub finishing_order ( $aref ) {
      my @o = @{$aref->[0]};
      my @f = @{$aref->[1]};
      my %h; $h{$o[$_]}=$_ for (0..$#o);
      sort {$h{$a}<=>$h{$b}} @f;
   }

   # Is a given input valid?
   sub is_valid ( $aref ) {
      # @$aref must contain exactly two elements:
      return false if 2 != scalar @$aref;
      # First array must be a permutation of its own indices base 1:
      my @o = @{$aref->[0]};
      for (@o) {return false if !m/^[1-9]\d*$/;}
      return false if join(',', sort {$a<=>$b} @o) ne join(',', (1..$#o+1));
      # Second array must be a strictly-increasing list of elements from
      # first array:
      my @f = @{$aref->[1]};
      my %h; $h{$_}=1 for @o;
      for (@f) {return false if !exists $h{$_};}
      for my $i (1..$#f) {return false if $f[$i] <= $f[$i-1];}
      # If $aref passes all of these tests, it's valid:
      return true;
   }

   # Parse lists of lists:
   sub parse_argv_2 ( @bash_args ) {
      my @args = ();
      foreach my $bash_arg (@bash_args) {
         my @lst_strs = map {trim $_} split ',', $bash_arg;
         push @args, [map {[split /\s+/, $_]} @lst_strs];
      }
      return @args;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? parse_argv_2(@ARGV) :
(
   [[3, 1, 4, 2, 5   ], [1, 2, 4   ]], # (1, 4, 2)
   [[5, 4, 3, 2, 1   ], [1, 3, 5   ]], # (5, 3, 1)
   [[2, 4, 1, 3      ], [1, 2, 3, 4]], # (2, 4, 1, 3)
   [[4, 1, 3, 2      ], [3         ]], # (3)
   [[1, 3, 2, 6, 5, 4], [1, 2, 3   ]], # (1, 3, 2)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my @o = defined($aref->[0]) ? @{$aref->[0]} : ();
   my @f = defined($aref->[1]) ? @{$aref->[1]} : ();
   say "Order   : (@o)";
   say "Friends : (@f)";
   if (!is_valid($aref)) {
      warn "Error: Argument must be a comma-separated pair of space-separated lists\n"
          ."of unique positive integers. The first list must be a permutation of its\n"
          ."own 1-based indices. The second list must consist only of members of the\n"
          ."first list, in strictly-increasing order. Eg: '1 3 2,2 3'\n";
      next;
   }
   my @s = finishing_order($aref);
   say "Finish  : (@s)";
}
