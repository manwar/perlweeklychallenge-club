use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 290
=========================

TASK #2
-------
*Luhn's Algorithm*

Submitted by: Andrezgz

You are given a string $str containing digits (and possibly other characters
which can be ignored). The last digit is the payload; consider it separately.
Counting from the right, double the value of the first, third, etc. of the
remaining digits.

For each value now greater than 9, sum its digits.

The correct check digit is that which, added to the sum of all values, would
bring the total mod 10 to zero.

Return true if and only if the payload is equal to the correct check digit.

It was originally posted on [https://www.reddit.com/r/coolguides/comments/
1faosv9/a_cool_guide_on_how_to_validate_credit_card/?rdt=51254|reddit].

Example 1

  Input: "17893729974"
  Output: true

  Payload is 4.

  Digits from the right:

  7 * 2 = 14, sum = 5
  9 = 9
  9 * 2 = 18, sum = 9
  2 = 2
  7 * 2 = 14, sum = 5
  3 = 3
  9 * 2 = 18, sum = 9
  8 = 8
  7 * 2 = 14, sum = 5
  1 = 1

  Sum of all values = 56, so 4 must be added to bring the total mod 10 to zero.
  The payload is indeed 4.

Example 2

  Input: "4137 8947 1175 5904"
  Output: true

Example 3

  Input: "4137 8974 1175 5904"
  Output: false

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
2. A string is entered on the command-line.
3. If the constant VERBOSE is set to True, then an output of "false" is followed
   by the correct check digit.

Assumption
----------
The string "0" is valid because the sum of the empty set (of integers) is 0.

Reference
---------
"Luhn algorithm", _Wikipedia_, https://en.wikipedia.org/wiki/Luhn_algorithm

=end comment
#===============================================================================

use Test;

subset Digit  of UInt where 0 <= * <= 9;
subset Result of List where (Bool, Digit);

my Bool constant VERBOSE = True;

# Double the index, then, if the sum has 2 digits, add them together
# E.g., $DOUBLE_TO_DIGIT[ 7 ] is 5 because 2 * 7 = 14 and 1 + 4 = 5

my constant @DOUBLE-TO-DIGIT = 0, 2, 4, 6, 8, 1, 3, 5, 7, 9;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 290, Task #2: Luhn's Algorithm (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                           #= A string
)
#===============================================================================
{
    qq[Input: "$str"].put;

    my Result $result = validate( $str );

    "Output: %s\n".printf: $result[ 0 ] ?? 'true' !! 'false';

    if VERBOSE && !$result[ 0 ]
    {
        my Str $payload = $str.substr: *-1, 1;

        ("\nThe current check digit is %s\n" ~
           "The correct check digit is %d\n").printf:
                +$payload ~~ Digit:D ?? $payload !! 'missing', $result[ 1 ];
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub validate( Str:D $str --> Result:D )
#-------------------------------------------------------------------------------
{
    my Result $result = (False, 0);
    my Str    @chars  =  $str.split: '', :skip-empty;

    if @chars.elems > 0
    {
        my Str  $payload = @chars.pop;
        my UInt $sum     = 0;
        my Bool $double  = True;

        loop (my $i = @chars.end; $i >= 0; --$i)
        {
            my Str $char = @chars[ $i ];

            if +$char ~~ Digit:D
            {
                $sum   +=  $double ?? @DOUBLE-TO-DIGIT[ +$char ] !! +$char;
                $double = !$double;
            }
        }

        my Digit $check-digit = (10 - ($sum % 10)) % 10;
        my Bool  $is-valid    = +$payload ~~ Digit:D &&
                                +$payload == $check-digit;

        $result = ($is-valid, $check-digit);
    }

    return $result;
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

        my Result $result = validate( $str );

        is $result[ 0 ] ?? 'true' !! 'false', $expected, $test-name;
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
        Example 1 |17893729974        |true
        Example 2 |4137 8947 1175 5904|true
        Example 3 |4137 8974 1175 5904|false
        Example 1a|a1b7c8d9e3f7g2h9974|true
        END
}

################################################################################
