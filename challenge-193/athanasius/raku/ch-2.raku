use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 193
=========================

TASK #2
-------
*Odd String*

Submitted by: Mohammad S Anwar

You are given a list of strings of same length, @s.

Write a script to find the odd string in the given list. Use positional value
of alphabet starting with 0, i.e. a = 0, b = 1, ... z = 25.

    Find the difference array for each string as shown in the example. Then
    pick the odd one out.

Example 1:

  Input: @s = ("adc", "wzy", "abc")
  Output: "abc"

  Difference array for "adc" => [ d - a, c - d ]
                             => [ 3 - 0, 2 - 3 ]
                             => [ 3, -1 ]

  Difference array for "wzy" => [ z - w, y - z ]
                             => [ 25 - 22, 24 - 25 ]
                             => [ 3, -1 ]

  Difference array for "abc" => [ b - a, c - b ]
                             => [ 1 - 0, 2 - 1 ]
                             => [ 1, 1 ]

  The difference array for "abc" is the odd one.

Example 2:

  Input: @s = ("aaa", "bob", "ccc", "ddd")
  Output: "bob"

  Difference array for "aaa" => [ a - a, a - a ]
                             => [ 0 - 0, 0 - 0 ]
                             => [ 0, 0 ]

  Difference array for "bob" => [ o - b, b - o ]
                             => [ 14 - 1, 1 - 14 ]
                             => [ 13, -13 ]

  Difference array for "ccc" => [ c - c, c - c ]
                             => [ 2 - 2, 2 - 2 ]
                             => [ 0, 0 ]

  Difference array for "ddd" => [ d - d, d - d ]
                             => [ 3 - 3, 3 - 3 ]
                             => [ 0, 0 ]

  The difference array for "bob" is the odd one.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
2. To show the difference array for each string, set $VERBOSE to True. (This
   has no effect on the running of the test suite.)

Assumptions
-----------
1. The input list contains at least three strings.
2. Valid input strings are non-empty, and consist of lower case letters only.

=end comment
#==============================================================================

use Test;

subset S-type of Str where * ~~ / ^ <[ a .. z ]>+ $ /;

my UInt constant $TEST-FLDS = 3;
my Bool constant $VERBOSE   = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 193, Task #2: Odd String (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A list of 3+ same-length strings of lower case letters

    *@s where { .elems > 2 && .all ~~ S-type:D && .all.chars == @s[ 0 ].chars } 
)
#==============================================================================
{
    "Input:  \@s = (%s)\n".printf: @s.map( { qq["$_"] } ).join: ', ';

    my (Str $odd, Hash[Array[Str],Str] $diffs) = find-odd-string( @s );

    "Output: $odd".put;

    print-diff-arrays( $diffs ) if $VERBOSE;
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub find-odd-string
(
    List:D[Str:D] $s
--> List:D[Str:D, Hash:D[List:D[Str:D]],Str:D]
)
#------------------------------------------------------------------------------
{
    my Array[Str] %diff-arrays{Str} = get-all-diff-arrays( $s );

    my Str  $odd   = 'None';
    my UInt $elems = $s.elems;

    given my UInt $diffs = %diff-arrays.keys.elems
    {
        when 1
        {
            $odd ~= " (all $elems strings have the same difference array)";
        }

        when 2
        {
            for %diff-arrays.values -> Array[Str] $list
            {
                $odd = '"' ~ $list[ 0 ] ~ '"', succeed if $list.elems == 1;
            }

            proceed;
        }

        default
        {
            $odd ~= " (the $elems strings have $diffs distinct difference " ~
                      'arrays)';
        }
    }

    return $odd, %diff-arrays;
}

#------------------------------------------------------------------------------
sub get-all-diff-arrays( List:D[Str:D] $s --> Hash:D[List:D[Str:D]] )
#------------------------------------------------------------------------------
{
    my Array[Str] %diff-arrays{Str};

    for @$s -> Str $str
    {
        my Int @diffs = get-one-diff-array( $str );
        my Str $gist  = '[ ' ~ @diffs.join( ', ' ) ~ ' ]';

        %diff-arrays{ $gist }.push: $str;
    }

    return %diff-arrays;
}

#------------------------------------------------------------------------------
sub get-one-diff-array( Str:D $str --> List:D[Int:D] )
#------------------------------------------------------------------------------
{
    my Int @diffs;
    my Str @chars = $str.split: '', :skip-empty;

    for 1 .. $str.chars - 1 -> UInt $i
    {
        @diffs.push: @chars[ $i ].ord - @chars[ $i - 1 ].ord;
    }

    return @diffs;
}

#------------------------------------------------------------------------------
sub print-diff-arrays( Hash:D[List:D[Str:D],Str] $da2strs )
#------------------------------------------------------------------------------
{
    my Str %str2da;

    for %$da2strs.kv -> Str $key, Array[Str] $value          # Reverse the hash
    {
        for @$value -> Str $str
        {
            %str2da{ $str } = $key;
        }
    }

    "\n  Difference arrays:".put;

    for %str2da.keys.sort -> Str $str
    {
        qq[    "%s" => %s\n].printf: $str, %str2da{ $str };
    }
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $in, $expected) =
            $line.split: / \, \s* /, $TEST-FLDS, :skip-empty;

        my Str @s = $in.split: / \s+ /, :skip-empty;

        my (Str $odd, Any) = find-odd-string( @s );

        is $odd, $expected, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#------------------------------------------------------------------------------
sub test-data( --> Str:D )
#------------------------------------------------------------------------------
{
    return S:g/ \\ \n // with q:to/END/;
        Example 1, adc wzy abc,     abc
        Example 2, aaa bob ccc ddd, bob
        All same,  adc wzy vyx bed,     \
                   None (all 4 strings have the same difference array)
        Two odd,   mor jlo abc def,     \
                   None (the 4 strings have 2 distinct difference arrays)
        All odd,   abc acd ade aef afg, \
                   None (the 5 strings have 5 distinct difference arrays)
        Odd plus,  adc wzy abc jop kpq, \
                   None (the 5 strings have 3 distinct difference arrays)
        END
}

###############################################################################
