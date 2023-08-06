#!perl

################################################################################
=comment

Perl Weekly Challenge 228
=========================

TASK #2
-------
*Empty Array*

Submitted by: Mohammad S Anwar

You are given an array of integers in which all elements are unique.

Write a script to perform the following operations until the array is empty and
return the total count of operations.

    If the first element is the smallest then remove it otherwise move it to the
    end.

Example 1

  Input: @int = (3, 4, 2)
  Output: 5

  Operation 1: move 3 to the end: (4, 2, 3)
  Operation 2: move 4 to the end: (2, 3, 4)
  Operation 3: remove element 2: (3, 4)
  Operation 4: remove element 3: (4)
  Operation 5: remove element 4: ()

Example 2

  Input: @int = (1, 2, 3)
  Output: 3

  Operation 1: remove element 1: (2, 3)
  Operation 2: remove element 2: (3)
  Operation 3: remove element 3: ()

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value, the solution is followed by details of
   the operations performed.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use List::Util     qw( min );
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<int> ...]
  perl $0

    [<int> ...]    A non-empty list of unique integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 228, Task #2: Empty Array (Perl)\n\n";
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
        my @int = parse_command_line();

        printf "Input:  \@int = (%s)\n", join ', ', @int;

        my $ops = empty_array( \@int );

        printf "Output: %d\n", scalar @$ops;

        if ($VERBOSE)
        {
            print   "\n";
            print "$_\n" for @$ops;
        }
    }
}

#-------------------------------------------------------------------------------
sub empty_array
#-------------------------------------------------------------------------------
{
    my ($int) = @_;
    my  @ops;

    for (my $count = 1; scalar @$int > 0; ++$count)
    {
        my $min =  min   @$int;
        my $n   =  shift @$int;
        my $op  = "Operation $count: ";

        if ($n == $min)
        {
            $op .= "remove element $n";
        }
        else
        {
            push @$int, $n;

            $op .= "move $n to the end";
        }

        $op .= sprintf ': (%s)', join ', ', @$int;

        push @ops, $op;
    }

    return \@ops;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my %count;

    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x
                or error( qq["$_" is not a valid integer] );

        ++$count{ $_ };
    }

    for (values %count)
    {
        $_ == 1 or error( 'The integers in the input list are not unique' );
    }

    return @ARGV;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int_str, $expected) = split / \| /x, $line;

        for ($test_name, $int_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @int = split / \s+ /x, $int_str;
        my $ops = empty_array( \@int );

        is scalar @$ops, $expected, $test_name;
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
Example 1|      3 4 2| 5
Example 2|      1 2 3| 3
Reversed |6 5 4 3 2 1|21
Singleton|         42| 1
Negatives|-1 -2 -3 -4|10
