#!perl

################################################################################
=comment

Perl Weekly Challenge 247
=========================

TASK #2
-------
*Most Frequent Letter Pair*

Submitted by: Jorg Sommrey

You are given a string S of lower case letters 'a'..'z'.

Write a script that finds the pair of consecutive letters in S that appears most
frequently. If there is more than one such pair, choose the one that is the
lexicographically first.

Example 1

  Input: $s = 'abcdbca'
  Output: 'bc'

  'bc' appears twice in `$s`

Example 2

  Input: $s = 'cdeabeabfcdfabgcd'
  Output: 'ab'

  'ab' and 'cd' both appear three times in $s and 'ab' is lexicographically
  smaller than 'cd'.

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
2. If $VERBOSE is set to a true value, a short explanation is appended to the
   output.

=cut
#===============================================================================

use v5.32.1;   # Enables strictures
use warnings;
use Const::Fast;
use List::Util qw( max );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 <s>
  perl $0

    <s>    A string of two or more lower case letters ('a' .. 'z')\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 247, Task #2: Most Frequent Letter Pair (Perl)\n\n";
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
    elsif ($argc == 1)
    {
        my $s = $ARGV[ 0 ];

        $s =~ / ^ [a-z]{2,} $ /x
            or error( 'The input string contains invalid characters' );

        print  "Input:  \$s = '$s'\n";

        my ($max_freq, $pairs) = find_max_pairs( $s );

        printf "Output: '%s'\n", $pairs->[ 0 ];

        if ($VERBOSE)
        {
            print "\nExplanation:\nThe maximum pair frequency is $max_freq\n";

            printf  "Letter pairs appearing with a frequency of %d: %s\n",
                     $max_freq, join ', ', map { "'$_'" } @$pairs;
        }
    }
    else
    {
        error( "Expected 0 or 1 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_max_pairs
#-------------------------------------------------------------------------------
{
    my ($s) = @_;

    my %pairs;
     ++$pairs{ substr $s, $_, 2 } for 0 .. length( $s ) - 2;

    my $max_freq  = max values %pairs;
    my @max_pairs = sort grep { $pairs{ $_ } == $max_freq } keys %pairs;

    return ($max_freq, \@max_pairs);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $s, $exp_pair, $exp_freq, $exp_pairs_str) =
             split / \| /x, $line;

        for ($test_name, $s, $exp_pair, $exp_freq, $exp_pairs_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my ($max_freq, $pairs) = find_max_pairs( $s );

        my  @exp_pairs = split / \s+ /x, $exp_pairs_str;

        is        $pairs->[ 0 ], $exp_pair,  "$test_name: output";
        is        $max_freq,     $exp_freq,  "$test_name: max frequency";
        is_deeply $pairs,       \@exp_pairs, "$test_name: max freq pairs";
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
Example 1  |abcdbca          |bc|2|bc
Example 2  |cdeabeabfcdfabgcd|ab|3|ab cd
Alternating|ababababa        |ab|4|ab ba
Singletons |vutsrqponmlkj    |kj|1|kj lk ml nm on po qp rq sr ts ut vu
Block      |xxxxxxxxxx       |xx|9|xx
