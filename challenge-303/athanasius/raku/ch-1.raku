use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 303
=========================

TASK #1
-------
*3-digits Even*

Submitted by: Mohammad Sajid Anwar

You are given a list (3 or more) of positive integers, @ints.

Write a script to return all even 3-digits integers that can be formed using the
integers in the given list.

Example 1

  Input: @ints = (2, 1, 3, 0)
  Output: (102, 120, 130, 132, 210, 230, 302, 310, 312, 320)

Example 2

  Input: @ints = (2, 2, 8, 8, 2)
  Output: (222, 228, 282, 288, 822, 828, 882)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Although only 1-digit integers are used in the examples, the input integers
   may have any number of digits.
2. A 3-digit number cannot start with digit 0.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Three or more unsigned integers are entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 303, Task #1: 3-digits Even (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A list of 3 or more unsigned integers

    *@ints where { .elems >= 3 && .all ~~ UInt:D }
)
#===============================================================================
{
    "Input: \@ints = (%s)\n".printf: @ints.join: ', ';

    my UInt  @nums = find-three-digit-even-numbers( @ints );

    "Output:        (%s)\n".printf:  @nums.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-three-digit-even-numbers( List:D[UInt:D] $ints --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt  %nums{UInt};
    my UInt (@dig1, @dig2, @dig3);

    sort-ints( $ints, @dig1, @dig2, @dig3 );            # Discard 4+ digit nums

    combine-single-digits( @dig1, %nums );              # (a)(b)(c)

    $_ .= unique for @dig1, @dig2, @dig3;               # Remove duplicates

    for @dig1.grep: { $_ %% 2 } -> UInt $rhs            # (ab)(c)
    {
        ++%nums{ $_ *  10 + $rhs } for @dig2;
    }

    for @dig2.grep: { $_ %% 2 } -> UInt $rhs            # (a)(bc)
    {
        ++%nums{ $_ * 100 + $rhs } for @dig1;
    }

    ++%nums{ $_ } for @dig3.grep: { $_ % 2 == 0 };      # (abc)

    return |%nums.keys.sort;
}

#-------------------------------------------------------------------------------
sub sort-ints
(
    List:D[UInt:D] $ints,
    List:D[UInt:D] $dig1,
    List:D[UInt:D] $dig2,
    List:D[UInt:D] $dig3
)
#-------------------------------------------------------------------------------
{
    for @$ints -> UInt $n
    {
        if    $n <   10         # 1 digit
        {
            $dig1.push: $n;
        }
        elsif $n <  100         # 2 digits
        {
            $dig2.push: $n;
        }
        elsif $n < 1000         # 3 digits
        {
            $dig3.push: $n;
        }
      # else                    # 4+ digits: discard
    }
}

#-------------------------------------------------------------------------------
sub combine-single-digits( List:D[UInt:D] $dig1, Hash:D[UInt:D] $nums )
#-------------------------------------------------------------------------------
{
    for 0 .. $dig1.end -> UInt $i
    {
        my UInt $lhs = $dig1[ $i ];

        next if $lhs == 0;

        for 0 .. $dig1.end -> UInt $j
        {
            next if $i == $j;

            my UInt $mid = $dig1[ $j ];

            for 0 .. $dig1.end -> UInt $k
            {
                next if $k == $i;
                next if $k == $j;

                my UInt $rhs = $dig1[ $k ];

                next unless $rhs %% 2;

                my UInt $num = $lhs * 100 + $mid * 10 + $rhs;

                ++$nums{ $num };
            }
        }
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

        my UInt @ints = $int-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt @exp  = $exp-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt @nums = find-three-digit-even-numbers( @ints );

        is-deeply @nums, @exp, $test-name;
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
        Example 1   |2 1 3 0    |102 120 130 132 210 230 302 310 312 320
        Example 2   |2 2 8 8 2  |222 228 282 288 822 828 882
        1 & 2 digits|1 7 13 24 6|124 136 176 246 624 716 724
        3 digits    |123 246 980|246 980
        END
}

################################################################################
