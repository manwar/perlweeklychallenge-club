use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 240
=========================

TASK #1
-------
*Acronym*

Submitted by: Mohammad S Anwar

You are given an array of strings and a check string.

Write a script to find out if the check string is the acronym of the words in
the given array.

Example 1

  Input: @str = ("Perl", "Python", "Pascal")
         $chk = "ppp"
  Output: true

Example 2

  Input: @str = ("Perl", "Raku")
         $chk = "rp"
  Output: false

Example 3

  Input: @str = ("Oracle", "Awk", "C")
         $chk = "oac"
  Output: true

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

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 240, Task #1: Acronym (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D :$chk,                                 #= Check string
          *@str where { .all ~~ Str:D }          #= A list of strings
)
#===============================================================================
{
    qq[Input:  \@str = (%s)\n].printf: @str.map( { qq["$_"] } ).join: ', ';
    qq[        \$chk =  "$chk"].put;

    qq[Output: %s\n].printf: is-acronym( @str, $chk ) ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub is-acronym( List:D[Str:D] $str, Str:D $chk --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Str $acronym = $str.map( { .substr: 0, 1 } ).join: '';

    return $acronym.lc eq $chk.lc;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $strs, $chk, $expected) = $line.split: / \| /;

        for     $test-name, $strs, $chk, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @str    = $strs.split: / \s+ /;
        my Str $result = is-acronym( @str, $chk ) ?? 'true' !! 'false';

        is $result, $expected, $test-name;
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
        Example 1|Perl   Python Pascal|ppp|true
        Example 2|Perl   Raku         |rp |false
        Example 3|Oracle Awk C        |oac|true
        END
}

################################################################################
