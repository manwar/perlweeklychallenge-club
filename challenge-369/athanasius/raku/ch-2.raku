use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 369
=========================

TASK #2
-------
*Group Division*

Submitted by: Mohammad Sajid Anwar

You are given a string, group size and filler character.

Write a script to divide the string into groups of given size. In the last group
if the string doesn’t have enough characters remaining fill with the given
filler character.

Example 1

  Input: $str = "RakuPerl", $size = 4, $filler = "*"
  Output: ("Raku", "Perl")

Example 2

  Input: $str = "Python", $size = 5, $filler = "0"
  Output: ("Pytho", "n0000")

Example 3

  Input: $str = "12345", $size = 3, $filler = "x"
  Output: ("123", "45x")

Example 4

  Input: $str = "HelloWorld", $size = 3, $filler = "_"
  Output: ("Hel", "loW", "orl", "d__")

Example 5

  Input: $str = "AI", $size = 5, $filler = "!"
  Output: "AI!!!"

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
2. A string, a group size, and a filler character are entered on the command-
   line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 369, Task #2: Group Division (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D  $str,                                 #= A string
    UInt:D $size   where { $_ > 0 },             #= A group size
    Str:D  $filler where { .elems == 1 }         #= A filler character
)
#===============================================================================
{
    qq[Input:  \$str = "$str", \$ize = $size, \$filler = "$filler"].put;

    my Str @groups = divide-into-groups( $str, $size, $filler );

    qq[Output: (%s)\n].printf: @groups.map( { qq["$_"] } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub divide-into-groups
(
    Str:D  $str,                                 #= A string
    UInt:D $size   where { $_ > 0 },             #= A group size
    Str:D  $filler where { .elems == 1 }         #= A filler character
--> List:D[Str:D]
)
#-------------------------------------------------------------------------------
{
    my Str  @groups = ($str ~~ m:g/ . ** {$size} /).map: { ~$_ };
    my UInt $mod    =  $str.chars % $size;

    if $mod > 0       # Extract the last group and pad it with filler characters
    {
        my Str $end  = $str.substr: ($str.chars - $mod), $mod;
               $end ~= $filler x ($size - $mod);

        @groups.push: $end;
    }

    return @groups;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $size, $filler, $exp-str) =
                $line.split: / \| /;

        for     $test-name,       $size, $filler, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @groups   = divide-into-groups( $str, $size.Int, $filler );
        my Str @expected = $exp-str.split: / \s+ /, :skip-empty;

        is-deeply @groups, @expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    exit 0;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|RakuPerl|  4|*|Raku Perl
        Example 2|Python|    5|0|Pytho n0000
        Example 3|12345|     3|x|123 45x
        Example 4|HelloWorld|3|_|Hel loW orl d__
        Example 5|AI|        5|!|AI!!!
        END
}

################################################################################
