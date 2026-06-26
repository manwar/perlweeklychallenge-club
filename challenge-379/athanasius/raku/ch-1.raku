use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 379
=========================

TASK #1
-------
*Reverse String*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to reverse the given string without using standard reverse
function.

Example 1

  Input: $str = ""
  Output: ""

Example 2

  Input: $str = "reverse the given string"
  Output: "gnirts nevig eht esrever"

Example 3

  Input: $str = "Perl is Awesome"
  Output: "emosewA si lreP"

Example 4

  Input: $str = "v1.0.0-Beta!"
  Output: "!ateB-0.0.1v"

Example 5

  Input: $str = "racecar"
  Output: "racecar"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single string is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 379, Task #1: Reverse String (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                           #= A string
)
#===============================================================================
{
    qq[Input: \$str = "$str"].put;

    my Str $reversed = reverse-string( $str );

    qq[Output:       "$reversed"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub reverse-string( Str:D $str --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str @chars    = $str.split: '', :skip-empty;
    my Str $reversed = '';

    loop (my Int $i = @chars.end; $i >= 0; --$i)
    {
        $reversed ~= @chars[ $i ];
    }

    return $reversed;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected) = $line.split: '|';

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $reversed = reverse-string( $str );

        is $reversed, $expected, $test-name;
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
        Example 1||
        Example 2|reverse the given string|gnirts nevig eht esrever
        Example 3|Perl is Awesome|emosewA si lreP
        Example 4|v1.0.0-Beta!|!ateB-0.0.1v
        Example 5|racecar|racecar
        END
}

################################################################################
