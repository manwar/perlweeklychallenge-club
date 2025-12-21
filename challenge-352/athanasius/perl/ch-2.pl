#!perl

################################################################################
=comment

Perl Weekly Challenge 352
=========================

TASK #2
-------
*Binary Prefix*

Submitted by: Mohammad Sajid Anwar

You are given an array, @nums, where each element is either 0 or 1.

Define xi as the number formed by taking the first i+1 bits of @nums (from
$nums[0] to $nums[i]) and interpreting them as a binary number, with $nums[0]
being the most significant bit.

For example:

  If @nums = (1, 0, 1), then:

  x0 = 1 (binary 1)
  x1 = 2 (binary 10)
  x2 = 5 (binary 101)

  For each i, check whether xi is divisible by 5.

Write a script to return an array @answer where $answer[i] is true if
x<sub>i</sub> is divisible by 5, otherwise false.

Example 1

  Input: @nums = (0,1,1,0,0,1,0,1,1,1)
  Output: (true, false, false, false, false, true, true, false, false, false)

  Binary numbers formed (decimal values):
           0: 0
          01: 1
         011: 3
        0110: 6
       01100: 12
      011001: 25
     0110010: 50
    01100101: 101
   011001011: 203
  0110010111: 407

Example 2

  Input: @num = (1,0,1,0,1,0)
  Output: (false, false, true, true, false, false)

       1: 1
      10: 2
     101: 5
    1010: 10
   10101: 21
  101010: 42

Example 3

  Input: @num = (0,0,1,0,1)
  Output: (true, true, false, false, true)

      0: 0
     00: 0
    001: 1
   0010: 2
  00101: 5

Example 4

  Input: @num = (1,1,1,1,1)
  Output: (false, false, false, true, false)

      1: 1
     11: 3
    111: 7
   1111: 15
  11111: 31

Example 5

  Input: @num = (1,0,1,1,0,1,0,0,1,1)
  Output: (false, false, true, false, false, true, true, true, false, false)

           1: 1
          10: 2
         101: 5
        1011: 11
       10110: 22
      101101: 45
     1011010: 90
    10110100: 180
   101101001: 361
  1011010011: 723

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of binary digits is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<num> ...]
  perl $0

    [<num> ...]    A non-empty list of numbers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 352, Task #2: Binary Prefix (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my @nums = @ARGV;

        printf "Input:  \@num = (%s)\n", join ',', @nums;

        my $answers = find_answers( \@nums );

        printf "Output: (%s)\n",
                join ', ', map { $_ ? 'true' : 'false' } @$answers;
    }
}

#-------------------------------------------------------------------------------
sub find_answers
#-------------------------------------------------------------------------------
{
    my ($nums)   = @_;
    my  $bin_str = '';
    my  @answers;

    for my $i (0 .. $#$nums)
    {
        $bin_str .= $nums->[$i];

        push @answers, oct( "0b$bin_str" ) % 5 == 0;
    }

    return \@answers;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $num_str, $exp_str) = split / \| /x, $line;

        for ($test_name, $num_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @nums     = split //, $num_str;
        my $answers  = find_answers( \@nums );
        my @ans_str  = map { $_ ? 'true' : 'false' } @$answers;
        my @expected = map { $_ ? 'true' : 'false' } split //, $exp_str;

        is_deeply \@ans_str, \@expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1|0110010111|1000011000
Example 2|    101010|    001100
Example 3|     00101|     11001
Example 4|     11111|     00010
Example 5|1011010011|0010011100
