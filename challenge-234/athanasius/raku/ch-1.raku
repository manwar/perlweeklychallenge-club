use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 234
=========================

TASK #1
-------
*Common Characters*

Submitted by: Mohammad S Anwar

You are given an array of words made up of alphabetic characters only.

Write a script to return all alphabetic characters that show up in all words
including duplicates.

Example 1

  Input: @words = ("java", "javascript", "julia")
  Output: ("j", "a")

Example 2

  Input: @words = ("bella", "label", "roller")
  Output: ("e", "l", "l")

Example 3

  Input: @words = ("cool", "lock", "cook")
  Output: ("c", "o")

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Matching is NOT case-sensitive.
2. Characters in the output are listed in the order (and case) they have within
   the first word.

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

my regex Alpha { <[ A..Z a..z ]> };

subset AlphaChr of Str where / ^ <Alpha>  $ /;
subset AlphaStr of Str where / ^ <Alpha>+ $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 234, Task #1: Common Characters (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of alphabetic words

    *@words where { .elems > 0 && .all ~~ AlphaStr:D }
)
#===============================================================================
{
    "Input:  \@words = (%s)\n".printf: @words.map( { qq["$_"] } ).join: ', ';

    my AlphaChr @common = find-common-characters( @words );

    "Output: (%s)\n".printf: @common.map( { qq["$_"] } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-common-characters
(
    List:D[AlphaStr:D] $words where { .elems > 0 }
--> List:D[AlphaChr:D]
)
#-------------------------------------------------------------------------------
{
    my UInt %common{AlphaChr};
          ++%common{ $_ } for $words[ 0 ].lc.split: '', :skip-empty;

    for $words[ 1 .. $words.end ] -> AlphaStr $word
    {
        my UInt %next{AlphaChr};
              ++%next{ $_ } for $word.lc.split: '', :skip-empty;

        # Find the intersection

        %common{ $_ }:delete unless %next{ $_ }:exists for %common.keys;

        for %next.keys -> AlphaChr $chr
        {
            %common{ $chr } = %next{ $chr }
                if %common{ $chr }:exists && %next{ $chr } < %common{ $chr };
        }
    }

    my AlphaChr @common;

    for $words[ 0 ].split( '', :skip-empty ) -> AlphaChr $chr
    {
        my AlphaChr $key = $chr.lc;

        if %common{ $key }:exists && %common{ $key } > 0
        {
            @common.push: $chr;
            --%common{ $key };
        }
    }

    return @common;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $words-str, $exp-str) =
                $line.split: / \| /;

        for     $test-name, $words-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my AlphaStr @words  = $words-str.split: / \s+ /, :skip-empty;
        my AlphaChr @exp    = $exp-str\ .split: / \s+ /, :skip-empty;
        my AlphaChr @common = find-common-characters( @words );

        is-deeply @common, @exp, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
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
        Example 1 |java  javascript julia |j a
        Example 2 |bella label      roller|e l l
        Example 3 |cool  lock       cook  |c o
        Mixed case|JavA  javascript julia |J a
        END
}

################################################################################
