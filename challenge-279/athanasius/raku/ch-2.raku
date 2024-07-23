use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 279
=========================

TASK #2
-------
*Split String*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str.

Write a script to split the given string into two containing exactly same number
of vowels and return true if you can otherwise false.

Example 1

  Input: $str = "perl"
  Output: false

Example 2

  Input: $str = "book"
  Output: true

  Two possible strings "bo" and "ok" containing exactly one vowel each.

Example 3

  Input: $str = "good morning"
  Output: true

  Two possible strings "good " and "morning" containing two vowels each or
  "good m" and "orning" containing two vowels each.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If an explanation of the output (i.e., one possible solution) is wanted,
   "--verbose" is entered as a command-line flag.
3. A single string is given as the last entry on the command-line.

=end comment
#===============================================================================

use Test;

subset Result of List where (Bool, Str, Str, UInt);

my regex Vowel    { :i <+[ A E I O U ]> };
my regex NonVowel { :i <-[ A E I O U ]> };

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 279, Task #2: Split String (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D   $str,                          #= A string
    Bool:D :$verbose = False               #= Explain the output?
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my (Bool $can-split, Str $lhs, Str $rhs, UInt $vowels) =
        split-string( $str, $verbose );

    "Output: %s\n".printf: $can-split ?? 'true' !! 'false';

    if $verbose && $can-split
    {
        "\nThis is a solution:".put;
        qq["%s" and "%s" each contain %d vowel%s\n].printf:
            $lhs, $rhs, $vowels, $vowels == 1 ?? '' !! 's';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub split-string( Str:D $str, Bool:D $verbose = True --> Result:D )
#-------------------------------------------------------------------------------
{
    my Bool $can-split = False;
    my Str  $lhs       = '';
    my Str  $rhs       = '';
    my Str  $vowel-str = S:g/ <NonVowel> // with $str;
    my UInt $n-vowels  = $vowel-str.chars;
    my UInt $target    = 0;

    if $n-vowels %% 2
    {
        $can-split = True;

        if $verbose
        {
            if $n-vowels == 0
            {
                my UInt $i = ($str.chars / 2).ceiling;

                $lhs = $str.substr: 0  .. $i - 1;
                $rhs = $str.substr: $i .. *;
            }
            else
            {
                ($can-split, $lhs, $rhs, $target) =
                    perform-split( $str, $n-vowels );
            }
        }
    }

    return $can-split, $lhs, $rhs, $target;
}

#-------------------------------------------------------------------------------
sub perform-split( Str:D $str, UInt:D $n-vowels --> Result:D )
#-------------------------------------------------------------------------------
{
    my UInt $target = ($n-vowels / 2).floor;
    my Str  @chars  =  $str.split: '', :skip-empty;
    my Str  $lhs    = '';
    my Str  $rhs    = '';
    my UInt $v      =  0;

    for 0 .. @chars.end -> UInt $i
    {
        if @chars[ $i ] ~~ / <Vowel> / && ++$v == $target
        {
            $lhs = @chars[ 0      .. $i ].join;
            $rhs = @chars[ $i + 1 .. *  ].join;
            last;
        }
    }

    $rhs ~~ / ^ ( <NonVowel>* ) /;

    my UInt $w = ((~$0).chars / 2).ceiling;

    $lhs ~= $rhs.substr: 0, $w;

    $rhs.substr-rw( 0, $w ) = '';

    return True, $lhs, $rhs, $target;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $exp-split-str, $exp-lhs, $exp-rhs) =
                $line.split: / \| /;

        for     $test-name, $str, $exp-split-str, $exp-lhs, $exp-rhs
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        s:g/_/ / for $str, $exp-lhs, $exp-rhs;

        my (Bool $can-split, Str $lhs, Str $rhs) = split-string( $str );
        my  Bool $exp-split = $exp-split-str eq 'true';

        is $can-split, $exp-split, $test-name;

        if $can-split
        {
            is $lhs, $exp-lhs, $test-name;
            is $rhs, $exp-rhs, $test-name;
        }
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
    # An initial or trailing space in the input and output strings is represent-
    # ed by an underscore (e.g., "good_ " represents "good ")

    return q:to/END/;
        Example 1  |perl        |false|      |
        Example 2  |book        |true |bo    |ok
        Example 3  |good morning|true |good_ |morning
        No vowels 1|BcdfghJklmnp|true |Bcdfgh|Jklmnp
        No vowels 2|BcdfghJklmn |true |Bcdfgh|Jklmn
        All vowels |aeiouAEIOU  |true |aeiou |AEIOU
        Empty      |            |true |      |
        END
}

################################################################################
