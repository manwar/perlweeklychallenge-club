use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 328
=========================

TASK #2
-------
*Good String*

Submitted by: Mohammad Sajid Anwar

You are given a string made up of lower and upper case English letters only.

Write a script to return the good string of the given string. A string is called
good string if it doesn’t have two adjacent same characters, one in upper case
and other is lower case.

UPDATE [2025-07-01]: Just to be explicit, you can only remove pair if they are
same characters, one in lower case and other in upper case, order is not
important.

Example 1

  Input: $str = "WeEeekly"
  Output: "Weekly"

  We can remove either, "eE" or "Ee" to make it good.

Example 2

  Input: $str = "abBAdD"
  Output: ""

  We remove "bB" first: "aAdD"
  Then we remove "aA": "dD"
  Finally remove "dD".

Example 3

  Input: $str = "abc"
  Output: "abc"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string made up of lower and upper case English letters only is entered on
   the command-line.

Assumptions
-----------


=end comment
#===============================================================================

use Test;

my Str $pair-rx;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 328, Task #2: Good String (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A string made up of lower and upper case English letters only

    Str:D $str where / ^ <[ A..Z a..z ]>* $ /
)
#===============================================================================
{
    qq[Input: \$str = "$str"].put;

    my Str $good-str = get-good-str( $str );

    qq[Output:       "$good-str"].put:
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    my Str @pairs;
           @pairs.push: $_ ~ .uc, .uc ~ $_ for 'a' .. 'z';

    $pair-rx = @pairs.join: '||';
}

#-------------------------------------------------------------------------------
sub get-good-str( Str:D $str where / ^ <[ A..Z a..z ]>* $ / --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $good-str = $str;

    Nil while $good-str ~~ s/ <$pair-rx> //;

    return $good-str;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected) = $line.split: / \| /;

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $good-str = get-good-str( $str );

        is $good-str, $expected, $test-name;
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
        Example 1|WeEeekly|Weekly
        Example 2|abBAdD  |
        Example 3|abc     |abc
        END
}

################################################################################
