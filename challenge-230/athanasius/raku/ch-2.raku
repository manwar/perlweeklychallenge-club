use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 230
=========================

TASK #2
-------
*Count Words*

Submitted by: Mohammad S Anwar

You are given an array of words made up of alphabetic characters and a prefix.

Write a script to return the count of words that starts with the given prefix.

Example 1

  Input: @words  = ("pay", "attention", "practice", "attend")
         $prefix = "at"
  Output: 2

  Two words "attention" and "attend" starts with the given prefix "at".

Example 2

  Input: @words  = ("janet", "julia", "java", "javascript")
         $prefix = "ja"
  Output: 3

  Three words "janet", "java" and "javascript" starts with the given prefix
  "ja".

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
If the prefix and the word are identical, this is considered a match.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $CASE-SENSITIVE is set to True (the default), the prefix must be an exact
   match; otherwise, e.g., "and" is considered a prefix of "Andes".
3. If $VERBOSE is set to True (the default), the solution is followed by a list
   of the matching words.

=end comment
#===============================================================================

use Test;

my Bool constant $CASE-SENSITIVE = True;
my Bool constant $VERBOSE        = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 230, Task #2: Count Words (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| Prefix made up of alphabetic characters

    Str:D $prefix where {         / ^ <[ A..Z a..z ]>+ $ / },

    #| List of words made up of alphabetic characters

         *@words  where { .all ~~ / ^ <[ A..Z a..z ]>+ $ / }
)
#===============================================================================
{
    qq[Input:  \@words  = (%s)\n].printf: @words.map( { qq["$_"] } ).join: ', ';
    qq[        \$prefix =  "$prefix"].put;

    my Str @matches = find-matches( $prefix, @words );

    "Output: %d\n".printf: @matches.elems;

    if $VERBOSE
    {
        qq[\nWords starting with the prefix "$prefix": %s\n].printf:
            @matches.map( { qq["$_"] } ).join: ', ';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-matches( Str:D $prefix, List:D[Str:D] $words --> List:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Str @matches;

    my Regex $re = $CASE-SENSITIVE ?? regex {    ^ $prefix }
                                   !! regex { :i ^ $prefix };

    for @$words -> Str $word
    {
        @matches.push: $word if $word ~~ $re;
    }

    return @matches;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $prefix, $words-str, $expected-str) =
                $line.split: / \| /;

        for     $test-name, $prefix, $words-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @words    = $words-str\  .split: / \s+ /, :skip-empty;
        my Str @expected = $expected-str.split: / \s+ /, :skip-empty;
        my Str @matches  = find-matches( $prefix, @words );

        is-deeply @matches, @expected, $test-name;
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
        Example 1 |at |pay attention practice attend|attention attend
        Example 2 |ja |janet julia java javascript  |janet java javascript
        No matches|xyz|in the beginning             |
        Non-prefix|and|understand grandly landrover |
        Mixed     |and|understand and andes         |and andes
        END
}

################################################################################
