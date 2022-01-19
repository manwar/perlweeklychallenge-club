use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 142
=========================

TASK #1
-------
*Divisor Last Digit*

Submitted by: Mohammad S Anwar

You are given positive integers, $m and $n.

Write a script to find total count of divisors of $m having last digit $n.

Example 1:

 Input: $m = 24, $n = 2
 Output: 2

 The divisors of 24 are 1, 2, 3, 4, 6, 8 and 12.
 There are only 2 divisors having last digit 2 are 2 and 12.

Example 2:

 Input: $m = 30, $n = 5
 Output: 2

 The divisors of 30 are 1, 2, 3, 5, 6, 10 and 15.
 There are only 2 divisors having last digit 5 are 5 and 15.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Configuration
-------------
1. $INCLUDE-M
   The "divisors" of $m usually include both 1 and $m itself. However, in the
   two examples given in the task description, $m is omitted from the list of
   divisors. The constant $INCLUDE-M (False by default) may be set to True to
   ensure that $m will be included in the output if it is divisible by $n.
2. $VERBOSE
   When this is set to True (the default), the output will be followed by an
   explanation similar to the explanations shown in the Examples. This explana-
   tion will be omitted if $VERBOSE is set to False.

Algorithm
---------
The subroutine find-divisors() is copied from the solution to Task 1 in Week
141:

    1. Divisors come in pairs: if i is a divisor of n then j = n / i is also a
       divisor of n
    2. If i = j then i = sqrt(n)

    So, to find all the divisors of n by searching, it's only necessary to
    search the range 1 to sqrt(n):

        divisors := empty
        FOR d in range 1 to ⌊sqrt(n)⌋
            IF d is a divisor of n THEN
                Add d to divisors
                d1 := n / d
                IF d < d1
                    Add d1 to divisors
                ENDIF
            ENDIF
        ENDFOR
        sort divisors ascending

=end comment
#==============================================================================

my Bool constant $INCLUDE-M = False;
my Bool constant $VERBOSE   = True;

subset Positive of Int where * > 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 142, Task #1: Divisor Last Digit (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Positive:D $m,                         #= A positive integer
    UInt:D     $n where $n < 10            #= A decimal digit (0-9)
)
#==============================================================================
{
    "Input:  \$m = $m, \$n = $n".put;

    my Positive @divisors = find-divisors( $m );

    @divisors.pop unless $INCLUDE-M;

    my Positive @solution = @divisors.grep: { / $n $ / };
    my UInt     $count    = @solution.elems;

    "Output: $count".put;

    if $VERBOSE
    {
        "\nThe divisors of %d are %s\n".printf:
            $m,
            @divisors.join: ', ';

        "Of these, %d ha%s %d as %s last digit%s\n".printf:
            $count,
            $count == 1 ?? 's'   !! 've',
            $n,
            $count == 1 ?? 'its' !! 'their',
            $count == 0 ?? ''    !! ': ' ~ @solution.join: ', ';
    }
}

#------------------------------------------------------------------------------
sub find-divisors( UInt:D $m --> Seq:D[Positive:D] )
#------------------------------------------------------------------------------
{
    my Positive @divisors;

    for 1 .. $m.sqrt.Int -> UInt $d
    {
        if $m % $d == 0
        {
            @divisors.push: $d;

            my UInt $d1 = $m div $d;          # Note: integer division

            @divisors.push: $d1 if $d < $d1;
        }
    }

    return @divisors.sort;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
