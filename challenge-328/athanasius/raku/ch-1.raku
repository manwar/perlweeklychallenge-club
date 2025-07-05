use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 328
=========================

TASK #1
-------
*Replace all ?*

Submitted by: Mohammad Sajid Anwar

You are given a string containing only lower case English letters and ?.

Write a script to replace all ? in the given string so that the string doesn’t
contain consecutive repeating characters.

Example 1

  Input: $str = "a?z"
  Output: "abz"

  There can be many strings, one of them is "abz".
  The choices are 'a' to 'z' but we can't use either 'a' or 'z' to replace the 
  '?'.                                                                      #'

Example 2

  Input: $str = "pe?k"
  Output: "peak"

Example 3

  Input: $str = "gra?te"
  Output: "grabte"

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
2. A string containing only lower case English letters and "?" is entered on the
   command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 328, Task #1: Replace all ? (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A string containing only lower case English letters and "?"

    Str:D $str where / ^ <[ a..z ? ]>* $ /
)
#===============================================================================
{
    qq[Input: \$str = "$str"].put;

    my Str $replaced = replace-queries( $str );

    qq[Output:       "$replaced"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub replace-queries( Str:D $str where / ^ <[ a..z ? ]>* $ / --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $replaced = '';
    my Str @chars    = $str.split: '', :skip-empty;

    for 0 .. @chars.end -> UInt $i
    {
        my Str $char = @chars[ $i ];

        if $char eq '?'
        {
            for 'a' .. 'z' -> Str $new
            {
                if ($i == 0          || $new ne @chars[ $i - 1 ]) &&
                   ($i == @chars.end || $new ne @chars[ $i + 1 ])
                {
                    $char = @chars[ $i ] = $new;
                    last;
                }
            }
        }

        $replaced ~= $char;
    }

    return $replaced;
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

        my Str $replaced = replace-queries( $str );

        is $replaced, $expected, $test-name;
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
        Example 1 |a?z   |abz
        Example 2 |pe?k  |peak
        Example 3 |gra?te|grabte
        Adjacent ?|ab??cd|ababcd
        All ?     |????? |ababa
        END
}

################################################################################
