use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 214
=========================

TASK #1
-------
*Rank Score*

Submitted by: Mohammad S Anwar

You are given a list of scores (>=1).

Write a script to rank each score in descending order. First three will get
medals i.e. G (Gold), S (Silver) and B (Bronze). Rest will just get the ranking
number.

    Using the standard model of giving equal scores equal rank, then advancing
    that number of ranks.

Example 1

  Input: @scores = (1,2,4,3,5)
  Output: (5,4,S,B,G)

  Score 1 is the 5th rank.
  Score 2 is the 4th rank.
  Score 4 is the 2nd rank i.e. Silver (S).
  Score 3 is the 3rd rank i.e. Bronze (B).
  Score 5 is the 1st rank i.e. Gold (G).

Example 2

  Input: @scores = (8,5,6,7,4)
  Output: (G,4,B,S,5)

  Score 8 is the 1st rank i.e. Gold (G).
  Score 5 is the 4th rank.
  Score 6 is the 3rd rank i.e. Bronze (B).
  Score 7 is the 2nd rank i.e. Silver (S).
  Score 4 is the 5th rank.

Example 3

  Input: @list = (3,5,4,2)
  Output: (B,G,S,4)

Example 4

  Input: @scores = (2,5,2,1,7,5,1)
  Output: (4,S,4,6,G,S,6)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 214, Task #1: Rank Score (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of positive integers

    *@scores where { .elems > 0 && .all ~~ Pos:D }
)
#===============================================================================
{
    "Input: \@scores = (%s)\n".printf: @scores.join: ',';

    my Str @ranked = rank-scores( @scores );

    "Output:          (%s)\n"\.printf: @ranked.join: ',';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub rank-scores( List:D[Pos:D] $scores --> List:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Pos %ranks{Pos} = assign-ranks( $scores );
    my Str @ranked;

    for @$scores -> Pos $score
    {
        my Pos $rank = %ranks{ $score.Int };

        @ranked.push: $rank == 1 ?? 'G' !!
                      $rank == 2 ?? 'S' !!
                      $rank == 3 ?? 'B' !! $rank.Str; 
    }

    return @ranked;
}

#-------------------------------------------------------------------------------
sub assign-ranks( List:D[Pos:D] $scores --> Hash:D[Pos:D] )
#-------------------------------------------------------------------------------
{
    my Pos  @sorted    = $scores.sort( { $^b leg $^a } ).map: { .Int };
    my UInt $this-rank = 0;
    my Pos  $next-rank = 1;
    my Pos  $prev;
    my Pos  %ranks{Pos};

    while @sorted
    {
        my Pos $top = @sorted.shift;

        if $prev.defined && $prev == $top
        {
            ++$next-rank;
        }
        else
        {
            $this-rank = $next-rank++;
        }

        %ranks{ $top } = $this-rank;
        $prev          = $top;
    }

    return %ranks;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $scores, $expected) = $line.split: / \| /;

        s/ \s+ $ // for $test-name, $scores;         # Trim whitespace

        my Str @expected = $expected.split: ',';
        my Pos @scores   = $scores\ .split( ',' ).map: { .Int };
        my Str @got      = rank-scores( @scores );

        is-deeply @got, @expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|1,2,4,3,5    |5,4,S,B,G
        Example 2|8,5,6,7,4    |G,4,B,S,5
        Example 3|3,5,4,2      |B,G,S,4
        Example 4|2,5,2,1,7,5,1|4,S,4,6,G,S,6
        Long tie |3,1,3,3,3,3  |G,6,G,G,G,G
        END
}

################################################################################
