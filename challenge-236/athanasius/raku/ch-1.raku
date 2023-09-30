use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 236
=========================

TASK #1
-------
*Exact Change*

Submitted by: Mohammad S Anwar

You are asked to sell juice each costs $5. You are given an array of bills. You
can only sell ONE juice to each customer but make sure you return exact change
back. You only have $5, $10 and $20 notes. You do not have any change in hand at
first.

Write a script to find out if it is possible to sell to each customers with
correct change.

Example 1

  Input: @bills = (5, 5, 5, 10, 20)
  Output: true

  From the first 3 customers, we collect three $5 bills in order.
  From the fourth customer, we collect a $10 bill and give back a $5.
  From the fifth customer, we give a $10 bill and a $5 bill.
  Since all customers got correct change, we output true.

Example 2

  Input: @bills = (5, 5, 10, 10, 20)
  Output: false

  From the first two customers in order, we collect two $5 bills.
  For the next two customers in order, we collect a $10 bill and give back a $5
  bill.
  For the last customer, we can not give the change of $15 back because we only
  have two $10 bills.
  Since not every customer received the correct change, the answer is false.

Example 3

  Input: @bills = (5, 5, 5, 20)
  Output: true

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

subset Bill of Int where * ~~ 5 | 10 | 20;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 236, Task #1: Exact Change (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A list of bills: $5, $10, and $20 only

    *@bills where { .elems > 0 && .all ~~ Bill:D }
)
#===============================================================================
{
    "Input:  \@bills = (%s)\n".printf: @bills.join: ', ';

    my Bool $can-give-change = give-change( @bills );

    "Output: %s\n".printf: $can-give-change ?? 'True' !! 'False';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub give-change( List:D[Bill:D] $bills --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt %cash-in-hand{Bill} = 5 => 0, 10 => 0, 20 => 0;

    for @$bills -> Bill $bill
    {
        ++%cash-in-hand{ $bill.Int };

        if    $bill == 10       #  $5 change due
        {
            return False if %cash-in-hand{ 5 } == 0;

            --%cash-in-hand{ 5 };
        }
        elsif $bill == 20       # $15 change due
        {
            if    %cash-in-hand{ 10 } >= 1 &&
                  %cash-in-hand{  5 } >= 1
            {
                --%cash-in-hand{ 10 };
                --%cash-in-hand{  5 };
            }
            elsif %cash-in-hand{  5 } >= 3
            {
                  %cash-in-hand{  5 } -= 3;
            }
            else
            {
                return False;
            }
        }
    }

    return True;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $bills-str, $expected) = $line.split: / \| /;

        for     $test-name, $bills-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Bill @bills           = $bills-str.split( / \s+ / ).map: { .Int };
        my Str  $can-give-change = give-change( @bills ) ?? 'True' !! 'False';

        is $can-give-change, $expected, $test-name;
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
        Example 1|5 5  5 10 20|True
        Example 2|5 5 10 10 20|False
        Example 3|5 5  5 20   |True
        END
}

################################################################################
