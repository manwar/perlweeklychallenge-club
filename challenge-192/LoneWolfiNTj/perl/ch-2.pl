#! /usr/bin/env perl
# PWCC Challenge 192 Task 1 solution by Robbie Hatley

=pod

Task 2: Communism (Equal Distribution)
Submitted by: Mohammad S Anwar

Given a list of non-negative integers, write a script to distribute
the total value of the numbers in the list evenly among the list's
members so that every member is the same number (if that's possible).
If you succeed then print the total moves; otherwise, print -1.
Please follow the rules suggested by Neils van Dijke:
1) You can only move a value of '1' per move
2) You are only allowed to move a value of '1' to
   a direct neighbor/adjacent cell

Example 1: Input=(1, 0, 5) Output=4
Example 2: Input=(0, 2, 0) Output=-1
Example 3: Input=(0, 3, 0) Output=2

=cut

# NOTE: Input is by either default array-of-arrays, or by CLI.
#       If inputting by CLI, input must be a single space-separated
#       sequence of one or more integers.

# NOTE: Output is to stdout and will be either number of steps to
#       achieve equal wealth distribution among citizens, or -1 if
#       no such distribution is possible.

use v5.36;
use List::Util "sum0";

# Does a string represent an integer?
sub is_int ($x)
{
   if ($x =~ m/(?:^0$)|(?:^-?[1-9][0-9]*$)/)    {return 1}
   else                                         {return 0}
}

# Do ALL strings in an array prepresent integers?
sub all_are_int (@a)
{
   for (@a) {if (!is_int($_))                   {return 0}}
                                                 return 1;
}

# Is the wealth distribution of the citizens of this realm equal?
sub egalite (@array)
{
   for (1..$#array) {if ($array[$_]!=$array[0]) {return 0}}
                                                 return 1
}

# Is the wealth in this realm NOT evenly distributable?
sub noblesse_oblige (@array)
{
   if (sum0(@array)%scalar(@array))             {return 1}
                                                 return 0
}

# What is the SSN of the left-most poorest citizen?
sub lmp (@array)
{
   my $lmp_idx = 0;
   my $lmp_amt = $array[0];
   for (1..$#array) {if ($array[$_] < $lmp_amt) {$lmp_idx = $_;$lmp_amt=$array[$_]}}
   return $lmp_idx;
}

# What is the SSN of the left-most richest citizen?
sub lmr (@array)
{
   my $lmr_idx = 0;
   my $lmr_amt = $array[0];
   for (1..$#array) {if ($array[$_] > $lmr_amt) {$lmr_idx = $_;$lmr_amt=$array[$_]}}
   return $lmr_idx;
}

# Default inputs:
my @inputs = ([1,0,5],[0,2,0],[0,3,0]);

# Non-default input:
if (scalar(@ARGV) > 0)
{
   if (all_are_int(@ARGV))
   {
      @inputs = ([@ARGV]);
   }
   else
   {
      die "Error: input must be space-separated sequence of ".
          "one-or-more integers.\n";
   }
}

# Process each input array:
for (@inputs)
{
   my @array = @$_;
   my @copy  = @array;
   my $moves;

   # Do the citizens of this realm already possess the same # of $ each?
   if (egalite(@array))
      {$moves = 0;}

   # Is the wealth in this realm NOT evenly distributable?
   elsif (noblesse_oblige(@array))
      {$moves = -1;}

   # If we get to here, we have wealth to redistribute! Eat the rich!
   else
   {
      $moves = 0;
      while (!egalite(@copy))
      {
         my $lmp=lmp(@copy);
         my $lmr=lmr(@copy);
         my $vec=$lmp-$lmr;
         my $dir=$vec/abs($vec);
         my $idx=$lmr;
         while ($idx!=$lmp)
         {
            my $nxt = $idx + $dir;
            --$copy[$idx];
            ++$copy[$nxt];
            ++$moves;
            $idx=$nxt;
         } # end while (moving $1)
      } # end while (no egalite yet)
   } # end else (eat the rich)

   # Announce moves for this input array:
   say "(@array) -> $moves";

}          # end for each input array
exit;      # end program
__END__    # end file