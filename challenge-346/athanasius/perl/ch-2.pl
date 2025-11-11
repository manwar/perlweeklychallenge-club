#!perl

################################################################################
=comment

Perl Weekly Challenge 346
=========================

TASK #2
-------
*Magic Expression*

Submitted by: Mohammad Sajid Anwar

You are given a string containing only digits and a target integer.

Write a script to insert binary operators +, - and * between the digits in the
given string that evaluates to target integer.

Example 1

  Input: $str = "123", $target = 6
  Output: ("1*2*3", "1+2+3")

Example 2

  Input: $str = "105", $target = 5
  Output: ("1*0+5", "10-5")

Example 3

  Input: $str = "232", $target = 8
  Output: ("2*3+2", "2+3*2")

Example 4

  Input: $str = "1234", $target = 10
  Output: ("1*2*3+4", "1+2+3+4")

Example 5

  Input: $str = "1001", $target = 2
  Output: ("1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1")

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
2. A string containing only digits is entered on the command-line, followed by
   and integer.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my @OPS   => qw( * + - ), '';
const my $USAGE => <<END;
Usage:
  perl $0 <str> <target>
  perl $0

    <str>       A string containing only digits
    <target>    A target integer
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 346, Task #2: Magic Expression (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 2)
    {
        my ($string, $target) = @ARGV;

        $string =~ / ^ [0-9]* $ /x
                        or error( qq["$string" is not a valid input string] );

        $target =~ / ^ $RE{num}{int} $ /x
                        or error( qq["$target" is not a valid target integer] );

        print  qq[Input:  \$str = "$string", \$target = $target\n];

        my $expressions = find_magic_expressions( $string, $target );

        printf "Output: (%s)\n", join ', ', map { qq["$_"] } @$expressions;
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_magic_expressions
#-------------------------------------------------------------------------------
{
    my ($str, $target) = @_;
    my  $length_str    = length $str;
    my  @expressions;

    if    ($length_str == 0)
    {
      # @expressions is already empty;
    }
    elsif ($length_str == 1)
    {
        push @expressions, $str == $target ? $str : ();
    }
    else
    {
        my @stack = (0) x ($length_str - 1);

        L_OUTER: for (my $level = $#stack; ; $level = $#stack)
        {
            my @chars = split //, $str;
            my $exp   = $chars[0];
               $exp  .= $OPS[ $stack[$_] ] . $chars[$_ + 1] for 0 .. $#stack;

            # Discard any "solution" in which 2+ digits begin with a zero

            push @expressions, $exp if $exp !~ /0\d/ && $target == eval $exp;

            while (++$stack[ $level ] > $#OPS)
            {
                last L_OUTER if $level == 0;

                $stack[ $level-- ] = 0;
            }
        }
    }

    return \@expressions;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $target, $expected_str) = split / \| /x, $line;

        for ($test_name, $str, $target, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $expressions = find_magic_expressions( $str, $target );
        my @expected    = split / \s+ /x, $expected_str;

        is_deeply $expressions, \@expected, $test_name;
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
Example 1| 123| 6|  1*2*3   1+2+3
Example 2| 105| 5|  1*0+5    10-5
Example 3| 232| 8|  2*3+2   2+3*2
Example 4|1234|10|1*2*3+4 1+2+3+4
Example 5|1001| 2|1+0*0+1 1+0+0+1 1+0-0+1 1-0*0+1 1-0+0+1 1-0-0+1
