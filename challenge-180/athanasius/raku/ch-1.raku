use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 180
=========================

TASK #1
-------
*First Unique Character*

Submitted by: Mohammad S Anwar

You are given a string, $s.

Write a script to find out the first unique character in the given string and
print its index (0-based).

Example 1

  Input: $s = "Perl Weekly Challenge"
  Output: 0 as 'P' is the first unique character

Example 2

  Input: $s = "Long Live Perl"
  Output: 1 as 'o' is the first unique character

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumptions
-----------
1. "Characters" are LETTERS only; whitespace, punctuation, and digits are
    ignored.
2.  Matching of characters (i.e., letters) is case-INsensitive.

Interface
---------
1. If no string argument is provided on the command line, a small test suite is
   run.
2. If the constant $VERBOSE is set to True, a short explanation is appended to
   the output (as per the Examples).

Note
----
Use of /[<:ASCII> & <.alpha>]/ in place of /<[A..Za..z]>/ is documented here:
https://www.codesections.com/blog/raku-unicode/

=end comment
#==============================================================================

use Test;

subset TestT of List where (Str, UInt);

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 180, Task #1: First Unique Character (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A non-empty string containing at least one letter

    Str:D $s where { / [<:ASCII> & <.alpha>] / }
)
#==============================================================================
{
    qq[Input:  \$s = "$s"].put;

    my UInt $index = find-index( $s );

    if $VERBOSE
    {
        if $index.defined
        {
            qq[Output: %s (as "%s" is the first unique character)\n].printf:
                $index, $s.substr( $index, 1 );
        }
        else
        {
            'Output: None (as no characters are unique)'.put;
        }
    }
    else
    {
        "Output: %s\n".printf: $index.defined ?? $index !! 'None';
    }
}

#==============================================================================
multi sub MAIN()                                                    # Run tests
#==============================================================================
{
    my TestT @tests = [ 'Perl Weekly Challenge',    0 ],
                      [ 'Long Live Perl',           1 ],
                      [ 'AaBbCcDdEeFfGgHhIiJj',  UInt ],       # All duplicated
                      [ 'AaBbCcDdEeFfGgHhIiJjK',   20 ],
                      [ ' abB',                     1 ];       # Ignore space

    for @tests -> TestT $test
    {
        my Str $test-name = '"' ~ $test[ 0 ] ~ '"';

        is find-index( $test[ 0 ] ), $test[ 1 ], $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub find-index( Str:D $s --> UInt )
#------------------------------------------------------------------------------
{
    my UInt %chars;

    for $s.split( '', :skip-empty ) -> Str $char
    {
        ++%chars{ $char.lc } if $char ~~ / ^ [<:ASCII> & <.alpha>] $ /;
    }

    my UInt $index;

    for 0 .. $s.chars - 1 -> UInt $i
    {
        my Str $key = $s.substr( $i, 1 ).lc;

        if %chars{ $key }:exists && %chars{ $key } == 1
        {
            $index = $i;
            last;
        }
    }

    return $index;
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
