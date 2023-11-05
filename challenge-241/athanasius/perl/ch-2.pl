#!perl

################################################################################
=comment

Perl Weekly Challenge 241
=========================

TASK #2
-------
*Prime Order*

Submitted by: Mohammad S Anwar

You are given an array of unique positive integers greater than 2.

Write a script to sort them in ascending order of the count of their prime
factors, tie-breaking by ascending value.

Example 1

  Input: @int = (11, 8, 27, 4)
  Output: (11, 4, 8, 27)

  Prime factors of 11 => 11
  Prime factors of  4 => 2, 2
  Prime factors of  8 => 2, 2, 2
  Prime factors of 27 => 3, 3, 3

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use v5.32.1;          # Enables strictures
use warnings;
use Const::Fast;
use List::Util        qw( uniqnum );
use Math::Prime::Util qw( factor );
use Regexp::Common    qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<int> ...]
  perl $0

    [<int> ...]  A non-empty list of unique positive integers greater than 2\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 240, Task #2: Prime Order (Perl)\n\n";
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
        my $int = parse_command_line();

        printf "Input:  \@int = (%s)\n", join ', ', @$int;

        my $sorted = prime_sort( $int );

        printf "Output:        (%s)\n",  join ', ', @$sorted;
    }
}

#-------------------------------------------------------------------------------
sub prime_sort
#-------------------------------------------------------------------------------
{
    my ($int) = @_;
    my  %count;
        $count{ $_ } = scalar factor( $_ ) for @$int;

    return [ sort { $count{ $a } <=> $count{ $b } || $a <=> $b } @$int ];
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        $_ > 2                 or error( qq["$_" is not greater than 2]  );
    }

    scalar @ARGV == scalar uniqnum( @ARGV )
        or error( 'Integers in the input list are not unique' );

    return \@ARGV;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int_str, $exp_str) = split / \| /x, $line;

        for ($test_name, $int_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @integers = split / \s+ /x, $int_str;
        my @expected = split / \s+ /x, $exp_str;
        my $sorted   = prime_sort( \@integers );

        is_deeply $sorted, \@expected, $test_name;
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
Example 1  | 11   8  27   4            | 11   4   8  27
Seq of 200s|207 208 209 210 211 212 213|211 209 213 207 212 210 208
