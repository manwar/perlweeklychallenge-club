use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 208
=========================

TASK #1
-------
*Minimum Index Sum*

Submitted by: Mohammad S Anwar

You are given two arrays of strings.

Write a script to find out all common strings in the given two arrays with
minimum index sum. If no common strings found returns an empty list.

Example 1

  Input: @list1 = ("Perl", "Raku", "Love")
         @list2 = ("Raku", "Perl", "Hate")

  Output: ("Perl", "Raku")

  There are two common strings "Perl" and "Raku".
  Index sum of "Perl": 0 + 1 = 1
  Index sum of "Raku": 1 + 0 = 1

Example 2

  Input: @list1 = ("A", "B", "C")
         @list2 = ("D", "E", "F")

  Output: ()

  No common string found, so no result.

Example 3

  Input: @list1 = ("A", "B", "C")
         @list2 = ("C", "A", "B")

  Output: ("A")

  There are three common strings "A", "B" and "C".
  Index sum of "A": 0 + 1 = 1
  Index sum of "B": 1 + 2 = 3
  Index sum of "C": 2 + 0 = 2

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

my Str constant $SEPARATOR = '-';

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 208, Task #1: Minimum Index Sum (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@list                 #= <string list 1> - <string list 2>
)
#===============================================================================
{
    my List  @lists = parse-command-line( @list );

    "Input: \@list1 = (%s)\n".printf: format-list( @lists[ 0 ] );
    "       \@list2 = (%s)\n".printf: format-list( @lists[ 1 ] );

    my Str @strings = |find-min-idx-strings( @lists );

    "\nOutput: (%s)\n".printf: format-list( @strings );
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-min-idx-strings( List:D[List:D[Str:D]] $lists --> List:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Array[Str] %common{ UInt };

    L-OUTER:
    for 0 .. $lists[ 0 ].end -> UInt $i
    {
        my Str $elem1 = $lists[ 0; $i ];

        for 0 .. $lists[ 1 ].end -> UInt $j
        {
            my Str $elem2 = $lists[ 1; $j ];

            if $elem1 eq $elem2
            {
                %common{ $i + $j }.push: $elem1;
                next L-OUTER;
            }
        }
    }

    return [] if %common.elems == 0;

    my UInt $min-idx = %common.keys.min;

    return %common{ $min-idx };
}

#-------------------------------------------------------------------------------
sub parse-command-line
(
    List:D[Str:D] $list --> List:D[ List:D[Str:D], List:D[Str:D] ]
)
#-------------------------------------------------------------------------------
{
    my Int $idx = -1;

    for 0 .. $list.end -> UInt $i
    {
        if $list[ $i ] eq $SEPARATOR
        {
            $idx = $i;
            last;
        }
    }

    $idx >= 0 or error( qq[Missing list separator "$SEPARATOR"] );

    return $list[ 0 .. $idx - 1  ], $list[ $idx + 1 .. $list.end ];
}

#-------------------------------------------------------------------------------
sub format-list( List:D[Str:D] $list --> Str:D )
#-------------------------------------------------------------------------------
{
    return $list.map( { qq["$_"] } ).join: ', ';
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $expected) = $line.split: / \| /;

        $test-name ~~ s/ \s+ $ //;

        my Str  @args    = $input.split: / \s+ /;
        my List @lists   =  parse-command-line( @args );
        my Str  @strings = |find-min-idx-strings( @lists );
        my Str  $got     = @strings.join: ' ';

        is $got, $expected, $test-name;
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
        Example 1|Perl Raku Love - Raku Perl Hate|Perl Raku
        Example 2|A B C          - D E F         |
        Example 3|A B C          - C A B         |A
        END
}

################################################################################
