use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

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

=end comment
#==============================================================================

use Test;

subset Pos of Int where * > 0;

my UInt constant $TEST-FIELDS = 3;
my UInt constant $TUPLE-SIZE  = 3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 187, Task #2: Magical Triplets (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A list of 3 or more positive integers

    *@n where { .elems >= $TUPLE-SIZE  && .all ~~ Pos:D }
)
#==============================================================================
{
    "Input: @n = (%s)\n".printf: @n.join: ', ';

    "Output:     (%s)\n".printf: find-triplet( @n ).join: ', ';
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $expected) =
            $line.split: / \, \s* /, $TEST-FIELDS, :skip-empty;

        $input ~~ / ^ \( (.*) \) $ /
            or die qq[Error matching \$input = "$input"];

        my Pos @n   = $0.Str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Str $out = '(' ~ find-triplet( @n ).join( ' ' ) ~ ')';

        is $out, $expected, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub find-triplet( List:D[Pos:D] $n --> List:D[Pos:D] )
#------------------------------------------------------------------------------
{
    my Pos @sorted = $n.sort: { $^b <=> $^a };       # Sort in descending order

    while @sorted.elems >= $TUPLE-SIZE
    {
        my Pos ($a, $b, $c) = @sorted[ 0 .. $TUPLE-SIZE - 1 ];

        return [$a, $b, $c] if $a < $b + $c;

        @sorted.shift;
    }

    return [];
}

#------------------------------------------------------------------------------
sub test-data()
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1, (1 2 3 2),  (3 2 2)
        Example 2, (1 3 2),    ()
        Example 3, (1 1 2 3),  ()
        Example 4, (2 4 3),    (4 3 2)
        All ones,  (1 1 10 1), (1 1 1)
        END
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
