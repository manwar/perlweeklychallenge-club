use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 321
=========================

TASK #2
-------
*Backspace Compare*

Submitted by: Mohammad Sajid Anwar

You are given two strings containing zero or more #.

Write a script to return true if the two given strings are same by treating # as
backspace.

Example 1

  Input: $str1 = "ab#c"
         $str2 = "ad#c"
  Output: true

  For first string,  we remove "b" as it is followed by "#".
  For second string, we remove "d" as it is followed by "#".
  In the end both strings became the same.

Example 2

  Input: $str1 = "ab##"
         $str2 = "a#b#"
  Output: true

Example 3

  Input: $str1 = "a#b"
         $str2 = "c"
  Output: false

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Backspace characters are processed from left to right within a string.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings, each containing zero or more "#" characters, are entered on the
   command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 321, Task #2: Backspace Compare (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str1,                        #= First  string
    Str:D $str2                         #= Second string
)
#===============================================================================
{
    qq[Input:  \$str1 = "$str1"].put;
    qq[        \$str2 = "$str2"].put;

    my Bool $strings-are-equal = compare-strings( $str1, $str2 );

    "Output: %s\n".printf: $strings-are-equal ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub compare-strings( Str:D $str1, Str:D $str2 --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Str $str1-nbs = process-backspaces( $str1 );
    my Str $str2-nbs = process-backspaces( $str2 );

    return $str1-nbs eq $str2-nbs;
}

#-------------------------------------------------------------------------------
sub process-backspaces( Str:D $str --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str @source = $str.split: '', :skip-empty;
    my Str @target;

    while  @source
    {
        my Str $next = @source.shift;

        if $next eq '#'
        {
            @target.pop if @target;
        }
        else
        {
            @target.push: $next;
        }
    }

    return @target.join: '';
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str1, $str2, $expected) = $line.split: / \| /;

        for     $test-name, $str1, $str2, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Bool $strings-are-equal = compare-strings( $str1, $str2 );

        is $strings-are-equal, $expected eq 'true', $test-name;
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
        Example 1|ab#c|ad#c|true
        Example 2|ab##|a#b#|true
        Example 3|a#b |c   |false
        END
}

################################################################################
