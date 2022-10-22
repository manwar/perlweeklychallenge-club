#!perl

###############################################################################
=comment

Perl Weekly Challenge 187
=========================

TASK #2
-------
*Magical Triplets*

Submitted by: Mohammad S Anwar

You are given a list of positive numbers, @n, having at least 3 numbers.

Write a script to find the triplets (a, b, c) from the given list that satis-
fies the following rules.

  1. a + b > c
  2. b + c > a
  3. a + c > b
  4. a + b + c is maximum.

In case, you end up with more than one triplets having the maximum then pick
the triplet where a >= b >= c.

Example 1

    Input: @n = (1, 2, 3, 2);
    Output: (3, 2, 2)

Example 2

    Input: @n = (1, 3, 2);
    Output: ()

Example 3

    Input: @n = (1, 1, 2, 3);
    Output: ()

Example 4

    Input: @n = (2, 4, 3);
    Output: (4, 3, 2)

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If no arguments are given on the command-line, the test suite is run.

Assumption
----------
A "positive number" is an integer greater than zero.

Algorithm
---------
1) Sort the input list in descending numerical order
2) WHILE there are at least 3 elements remaining in the list
      Select the first 3 elements in the list as a candidate triple
         T = <a, b, c>. Note that a, b, c ∈ N and a >= b >= c
      a) The requirement that a + b + c is a maximum is satisfied by the fact
         that a, b, c are drawn from the head of a list sorted in descending
         numerical order
      b) The requirement a + b > c is also guaranteed to be already satisfied:
         b >= c and a >= 1, so (a + b) must be at least 1 greater than c
      c) The requirement a + c > b is likewise guaranteed to be satisfied:
         a >= b and c >= 1, so (a + c) must be at least 1 greater than b
      d) It is therefore only necessary to test whether b + c > a:
            IF b + c > a THEN
                RETURN T as the solution
            ELSE
                It is pointless to test any additional triples containing
                element a, since all further candidates for the 2nd and 3rd
                positions in the triple are <= c, and we already know that
                b + c is too small; therefore, remove element a from the head
                of the list
            ENDIF
   ENDWHILE
3) If this point is reached, no solution has been found so RETURN an empty list

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common;
use Test::More;

const my $TEST_FIELDS => 3;
const my $TUPLE_SIZE  => 3;
const my $USAGE       =>
"Usage:
  perl $0 [<n> ...]
  perl $0

    [<n> ...]    A list of $TUPLE_SIZE or more positive integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 187, Task #2: Magical Triplets (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args >= $TUPLE_SIZE)
    {
        my @n = parse_command_line();

        printf "Input: \@n = (%s)\n", join ', ', @n;
        printf "Output:     (%s)\n",  join ', ', @{ find_triplet( \@n ) };
    }
    else
    {
        error( "Expected 0 or $TUPLE_SIZE+ arguments, found $args" );
    }
}

#------------------------------------------------------------------------------
sub find_triplet
#------------------------------------------------------------------------------
{
    my ($n_ref) = @_;
    my  @sorted = sort { $b <=> $a } @$n_ref;        # Sort in descending order

    while (scalar @sorted >= $TUPLE_SIZE)
    {
        my ($a, $b, $c) = @sorted[ 0 .. $TUPLE_SIZE - 1 ];

        return [ $a, $b, $c ] if $a < $b + $c;

        shift @sorted;
    }

    return [];
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my @n = @ARGV;

    for my $n (@n)
    {
        $n =~ / ^ $RE{num}{int} $ /x
               or error( qq["$n" is not a valid integer] );

        $n > 0 or error( qq["$n" is not positive] );
    }

    return @n;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $input, $expected) =
            split / , \s* /x, $line, $TEST_FIELDS;

        $input =~ / ^ \( (.*) \) $ /x
            or die qq[Error matching \$input = "$input"];

        my @n   = split /\s+/, $1;
        my $out = '(' . join( ' ', @{ find_triplet( \@n ) } ) . ')';

        is $out, $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1, (1 2 3 2),  (3 2 2)
Example 2, (1 3 2),    ()
Example 3, (1 1 2 3),  ()
Example 4, (2 4 3),    (4 3 2)
All ones,  (1 1 10 1), (1 1 1)
