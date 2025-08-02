use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 322
=========================

TASK #1
-------
*String Format*

Submitted by: Mohammad Sajid Anwar

You are given a string and a positive integer.

Write a script to format the string, removing any dashes, in groups of size
given by the integer. The first group can be smaller than the integer but should
have at least one character. Groups should be separated by dashes.

Example 1

  Input: $str = "ABC-D-E-F", $i = 3
  Output: "ABC-DEF"

Example 2

  Input: $str = "A-BC-D-E", $i = 2
  Output: "A-BC-DE"

Example 3

  Input: $str = "-A-B-CD-E", $i = 4
  Output: "A-BCDE"

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
2. A string, and a positive (non-zero) integer, are entered on the command-line.
3. If the string begins with a hyphen, it must be preceded by "--" to indicate
   that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 322, Task #1: String Format (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str,                #= A string
    Pos:D $i                   #= A positive (non-zero) integer
)
#===============================================================================
{
    qq[Input:  \$str = "$str", \$i = $i].put;

    my $grouped = format-string( $str, $i );

    qq[Output: "$grouped"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub format-string( Str:D $str, Pos:D $i --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $bare = S:g/ \- // given $str;
    my Str @groups;

    while  $bare ~~ s/ (. ** {1 .. $i}) $ //
    {
        @groups.unshift: ~$0;
    }

    return @groups.join: '-';
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $i-str, $expected) = $line.split: / \| /;

        for     $test-name, $str, $i-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my $grouped = format-string( $str, $i-str.Int );

        is $grouped, $expected, $test-name;
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
        Example 1|ABC-D-E-F|3|ABC-DEF
        Example 2|A-BC-D-E |2|A-BC-DE
        Example 3|-A-B-CD-E|4|A-BCDE
        END
}

################################################################################
