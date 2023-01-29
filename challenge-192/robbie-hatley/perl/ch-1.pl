#! /usr/bin/env perl
# PWCC Challenge 192 Task 1 solution by Robbie Hatley

=pod

Task 1: Binary Flip
Submitted by: Mohammad S Anwar

You are given a positive integer, $n. Write a script to find the
binary flip (that is, the positive integer consisting of all of
the significant digits of $n inverted).

Example 1: Input=5 Output=2
Example 2: Input=4 Output=3
Example 3: Input=6 Output=1

=cut

# NOTE: Input is by either default array or CLI. If inputting
#       by CLI, input must be a space-separated sequence of
#       one-or-more positive integers.

# NOTE: Output is to stdout and will be the binary flip(s)
#       of the input number(s).

use v5.36;

# Does a string represent a positive integer?
sub is_pos_int ($x)
{
   if ($x =~ m/^[1-9][0-9]*$/)                  {return 1}
   else                                         {return 0}
}

# Do ALL strings in an array prepresent positive integers?
sub all_are_pos_int (@a)
{
   for (@a) {if (!is_pos_int($_))               {return 0}}
                                                 return 1;
}

# What is the number of binary significant figures in a positive integer?
sub sigfigs ($n)
{
   my $sigfigs = 0;
   while ($n)
   {
      ++$sigfigs;
      $n >>= 1;
   }
   return $sigfigs;
}

# Default input:
my @array = (5,4,6);

# Non-default input:
if (scalar(@ARGV) > 0)
{
   if (all_are_pos_int(@ARGV))
   {
      @array = @ARGV;
   }
   else
   {
      die "Error: input must be space-separated sequence of ".
          "one-or-more positive integers.\n";
   }
}

# Process inputs and print outputs:
for (@array)
{
   my $n = $_ ;

   # How many sig figs are we dealing with here?
   my $sigfigs = &sigfigs($n);

   # Get the raw inverse of $n, including the left-zero-padding bits:
   my $inverse = ~$n;

   # Get the flip:
   my $flip = 0;
   for ( my $idx = 0 ; $idx < $sigfigs ; ++$idx )
   {
      $flip += ((($inverse >> $idx) % 2) << $idx);
   }
   say "$n flipped = $flip";
}
exit;
__END__