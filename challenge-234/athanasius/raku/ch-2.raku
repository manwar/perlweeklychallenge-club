use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 234
=========================

TASK #2
-------
*Unequal Triplets*

Submitted by: Mohammad S Anwar

You are given an array of positive integers.

Write a script to find the number of triplets (i, j, k) that satisfies num[i] !=
num[j], num[j] != num[k] and num[k] != num[i].

Example 1

  Input: @ints = (4, 4, 2, 4, 3)
  Output: 3

  (0, 2, 4) because 4 != 2 != 3
  (1, 2, 4) because 4 != 2 != 3
  (2, 3, 4) because 2 != 4 != 3

Example 2

  Input: @ints = (1, 1, 1, 1, 1)
  Output: 0

Example 3

  Input: @ints = (4, 7, 1, 10, 7, 4, 1, 1)
  Output: 28

  triplets of 1, 4, 7  = 3x2×2 = 12 combinations
  triplets of 1, 4, 10 = 3×2×1 = 6  combinations
  triplets of 4, 7, 10 = 2×2×1 = 4  combinations
  triplets of 1, 7, 10 = 3x2x1 = 6  combinations

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
A "positive" integer is greater than zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to True (the default), the output is followed by an
   explanation like that in Example 3.

=end comment
#===============================================================================

use Test;

my UInt constant $PROD-IDX = 6;
my UInt constant $SIZE     = 3;
my Bool constant $VERBOSE  = True;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 234, Task #2: Unequal Triplets (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of positive integers

    *@ints where { .elems > 0 && .all ~~ Pos:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my (UInt $count, Array[Array[Pos]] $table) =
        count-unequal-triplets( @ints, $VERBOSE );

    "Output: $count".put;

    print-table( $table ) if $VERBOSE && $count > 0;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-unequal-triplets
(
    List:D[Pos:D] $ints,
    Bool:D        $verbose = False
--> List:D[ UInt:D, List:D[List:D[Pos:D]] ]
)
#-------------------------------------------------------------------------------
{
    my UInt %dict{Pos};
          ++%dict{ $_ } for @$ints.map: { .Int };

    my UInt              $count = 0;
    my Pos               @keys  = %dict.keys.sort;
    my Array[Array[Pos]] $table = Array[Array[Pos]].new;

    for @keys.combinations: $SIZE
    {
        my Pos ($i, $j, $k) = @$_;

        my Pos $ival = %dict{ $i };
        my Pos $jval = %dict{ $j };
        my Pos $kval = %dict{ $k };
        my Pos $prod = $ival * $jval * $kval;

        $count += $prod;

        $table.push: Array[Pos].new: $i, $j, $k, $ival, $jval, $kval, $prod
            if $verbose;
    }

    return $count, $table;
}

#-------------------------------------------------------------------------------
multi sub print-table( List:D[List:D[Pos:D]] $table )
#-------------------------------------------------------------------------------
{
    my UInt $max-row = $table.end;
    my UInt $max-col = $table[ 0 ].end;
    my UInt @widths;

    # Calculate maximum column widths

    for 0 .. $max-col -> UInt $col
    {
        @widths[ $col ] = $table[ 0; $col ].chars;

        for 1 .. $max-row -> UInt $row
        {
            my UInt $new-len = $table[ $row; $col ].chars;

            @widths[ $col ]  = $new-len if $new-len > @widths[ $col ];
        }
    }

    # Print the table

    put();

    for @$table -> Array[Pos] $row-data
    {
        my $prod = $row-data[ $PROD-IDX ];

        ('Triplet (%*d, %*d, %*d) occurs in %*d×%*d×%*d = %*d ' ~
         "combination%s\n").printf: |(@widths Z @$row-data),
                                      $prod == 1 ?? '' !! 's';
    }
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $int-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Array[Array[Pos]] $table = Array[Array[Pos]].new;

        my Pos @ints = $int-str.split( / \s+ /, :skip-empty ).map: { .Int };

        my (UInt $count, List) = count-unequal-triplets( @ints );

        is $count, $exp-str.Int, $test-name;
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
        Example 1|4 4 2  4 3      | 3
        Example 2|1 1 1  1 1      | 0
        Example 3|4 7 1 10 7 4 1 1|28
        END
}

################################################################################
