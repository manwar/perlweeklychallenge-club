use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 253
=========================

TASK #1
-------
*Split Strings*

Submitted by: Mohammad S Anwar

You are given an array of strings and a character separator.

Write a script to return all words separated by the given character excluding
empty string.

Example 1

  Input: @words = ("one.two.three","four.five","six")
         $separator = "."
  Output: "one","two","three","four","five","six"

Example 2

  Input: @words = ("$perl$$", "$$raku$")
         $separator = "$"
  Output: "perl","raku"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 253, Task #1: Split Strings (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D :$separator where { .chars == 1 },     #= A single-character separator
          *@strings   where { .elems >  0 }      #= A non-empty list of strings
)
#===============================================================================
{
    qq[Input:  \@strings   = (%s)\n].printf:
                @strings.map( { qq["$_"] } ).join( ', ' );
    qq[        \$separator =  "$separator"].put;

    my Str @words = split-strings( $separator, @strings );

    qq[Output: %s\n].printf: @words.map( { qq["$_"] } ).join( ', ' );
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub split-strings( Str:D $separator, List:D[Str:D] $strings --> List:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Str @words;

    for @$strings -> Str $string
    {
        @words.push: |$string.split: $separator, :skip-empty;
    }

    return @words;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $strings-str, $separator, $expected-str) =
            $line.split: / \| /;

        for     $test-name, $strings-str, $separator, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @strings  = $strings-str\.split: / \s+ /;
        my Str @expected = $expected-str.split: / \s+ /;
        my Str @output   = split-strings( $separator, @strings );

        is-deeply @output, @expected, $test-name;
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
        Example 1|one.two.three four.five six|.|one two three four five six
        Example 2|$perl$$ $$raku$            |$|perl raku
        END
}

################################################################################
