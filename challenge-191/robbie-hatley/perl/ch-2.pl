#! /usr/bin/perl
#  PWCC 191 P2: "Cute List"

=pod

Task 2: Cute List
Submitted by: Mohammad S Anwar

You are given an integer, 0 < $n <= 15.

Write a script to find the number of orderings of numbers that form a cute list.

With an input @list = (1, 2, 3, .. $n) for positive integer $n, an ordering of @list is cute if for every entry, indexed with a base of 1, either

1) $list[$i] is evenly divisible by $i
or
2) $i is evenly divisible by $list[$i]

Example

Input: $n = 2
Ouput: 2

Since $n = 2, the list can be made up of two integers only i.e. 1 and 2.
Therefore we can have two list i.e. (1,2) and (2,1).

@list = (1,2) is cute since $list[1] = 1 is divisible by 1 and $list[2] = 2 is divisible by 2.

=cut

# NOTE: Input is via either default scalar (2) or @ARGV.
#       If an input in given via @ARGV it should be a single integer
#       in the 1..15 range.

# NOTE: Output is to stdout and will be the number of Cute Lists which
#       can be formed by permuting the array containing 1..n where n
#       is the integer which was input.

use v5.36;

# Set list item separate to " " for printing:
$,=' ';

sub permutations (@array)
{
   my @permutations;
   my $size = scalar(@array);
   if (0 == $size)
   {
      @permutations = ([]);
   }
   else
   {
      for ( my $idx = 0 ; $idx <= $#array ; ++$idx )
      {
         my @temp = @array;
         my @removed = splice @temp, $idx, 1;
         my @partials = permutations(@temp);
         unshift @$_, @removed for @partials;
         push @permutations, @partials;
      }
   }
   return @permutations;
}

sub is_cute (@list)
{
   for (my $idx = 0 ; $idx <= $#list ; ++$idx)
   {
      my $e = $list[$idx];
      my $o = $idx + 1;
      ($e%$o)*($o%$e) and return 0;
   }
   return 1;
}

# Default input:
my $n = 2;

# Non-default input:
if (1 == scalar(@ARGV) && 1<=$ARGV[0] && $ARGV[0]<=15) {$n=$ARGV[0];}

# Make an array of the integers from 1 through $n:
my @array = 1..$n;

# Make an array of arrays containing all possible permutations of @array:
my @permutations = permutations(@array);

# Make a cuteness counter (MLP alusion intentional):
my $cutie_mark = 0; # cutie mark hasn't been earned yet

# Make an array to hold all cuties found among permutations of @array:
my @cuties;

# For each permutation, if it's cute, add it to @cuties:
for (@permutations) {if (is_cute(@$_)) {push @cuties, $_}}

# Count cuties:
$cutie_mark = scalar (@cuties);

# Print cuties:
say "Original list = @array";
say "Found $cutie_mark cute permutations:";
say @$_ for @cuties;
