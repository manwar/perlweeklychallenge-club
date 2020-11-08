#!perl

###############################################################################
=comment

Perl Weekly Challenge 085
=========================

Task #2
-------
*Power of Two Integers*

Submitted by: Mohammad S Anwar

You are given a positive integer $N.

Write a script to find if it can be expressed as a ^ b where a > 0 and b > 1.
Print 1 if you succeed otherwise 0.

Example 1:

 Input: 8
 Output: 1 as 8 = 2 ^ 3

Example 2:

 Input: 15
 Output: 0

Example 3:

 Input: 125
 Output: 1 as 125 = 5 ^ 3

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

                                       # Exports:
use strict;
use warnings;
use Const::Fast;                       # const()
use Regexp::Common qw( number );       # %RE{num}

const my $EXPLAIN => 1;
const my $USAGE   =>
"Usage:
  perl $0 <N>

    <N>    A positive integer\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 085, Task #2: Power of Two Integers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $N = parse_command_line();

    print "Input:  $N\n";

    my ($base, $exp) = find_power($N);

    if ($base < 1)
    {
        print "Output: 0\n";
    }
    elsif ($EXPLAIN)
    {
        print "Output: 1 as $N = $base ^ $exp\n";
    }
    else
    {
        print "Output: 1\n";
    }
}

#------------------------------------------------------------------------------
sub find_power
#------------------------------------------------------------------------------
{
    my ($N)       = @_;
    my  $base     = 0;
    my  $exponent = 1;
    my  $root     = round(sqrt $N);

    if ($root * $root == $N)
    {
        $base     = $root;
        $exponent = 2;
    }
    else
    {
        my $max_exp = round(log($N) / log(2));

        for (my $exp = 3; $exp <= $max_exp; $exp += 2)
        {
               $root = round($N ** (1 / $exp));
            my $n    = 1;
               $n   *= $root for 1 .. $exp;

            if ($n == $N)
            {
                $base     = $root;
                $exponent = $exp;
                last;
            }
        }
    }

    return ($base, $exponent);
}

#------------------------------------------------------------------------------
sub round
#------------------------------------------------------------------------------
{
    my ($n) = @_;

    return int($n + 0.5);
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or die qq[ERROR: Expected a single command-line ]  .
                         qq[argument, found $args\n]                 . $USAGE;

    my $N = $ARGV[0];
       $N =~ / \A $RE{num}{int} \z /x
                  or die qq[ERROR: "$N" is not an integer\n]         . $USAGE;

       $N > 0     or die qq[ERROR: "$N" is not a positive integer\n] . $USAGE;

    return int $N;
}

###############################################################################
