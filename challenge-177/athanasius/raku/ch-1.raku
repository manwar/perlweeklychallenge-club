use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 177
=========================

TASK #1
-------
*Damm Algorithm*

Submitted by: Mohammad S Anwar

You are given a positive number, $n.

Write a script to validate the given number against the included check digit.

Please checkout the [ https://en.wikipedia.org/wiki/Damm_algorithm |wikipedia
page] for information.

Example 1

  Input: $n = 5724
  Output: 1 as it is valid number

Example 2

  Input: $n = 5727
  Output: 0 as it is invalid number

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Configuration
-------------
If $VERBOSE is set to True, the output includes an explanation which either
confirms that the check digit is correct or shows what the check digit should
be.

Algorithm
---------
Both the generation and the validation of a check digit proceed by traversing
the given operation table as follows [1, "Algorithm"]:

    1. $interim-digit := 0
    2. FOR each $digit in $n, from the most- to the least-significant
           $interim-digit := the value in the operation table corresponding
                             to row $digit and column $interim-digit
       ENDFOR
    3. $result := $interim-digit

- To generate a check digit: $n is the number for which the check digit is
  required; and $result is the required check digit.
- To validate a check digit: $n is the number to be validated *including its
  check digit* (which is always the final digit). The check digit is valid if
  and only if $result is 0.

Reference
---------
[1] "Damm algorithm", Wikipedia, https://en.wikipedia.org/wiki/Damm_algorithm

=end comment
#==============================================================================

my constant @OP-TABLE = Array[Array[UInt]].new:

    Array[UInt].new( 0, 3, 1, 7, 5, 9, 8, 6, 4, 2 ),
    Array[UInt].new( 7, 0, 9, 2, 1, 5, 4, 8, 6, 3 ),
    Array[UInt].new( 4, 2, 0, 6, 8, 7, 1, 3, 5, 9 ),
    Array[UInt].new( 1, 7, 5, 0, 9, 8, 3, 4, 2, 6 ),
    Array[UInt].new( 6, 1, 2, 3, 0, 4, 5, 9, 7, 8 ),
    Array[UInt].new( 3, 6, 7, 4, 2, 0, 9, 5, 8, 1 ),
    Array[UInt].new( 5, 8, 6, 9, 7, 2, 0, 1, 3, 4 ),
    Array[UInt].new( 8, 9, 4, 5, 3, 6, 2, 0, 1, 7 ),
    Array[UInt].new( 9, 4, 3, 8, 6, 1, 7, 2, 0, 5 ),
    Array[UInt].new( 2, 5, 8, 1, 4, 3, 6, 7, 9, 0 );

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 177, Task #1: Damm Algorithm (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $n where { $n > 9 }       #= A positive integer of at least 2 digits
)
#==============================================================================
{
    my Str $spaces = $VERBOSE ?? '     ' !! '';

    "Input:  %s\$n = %d\n".printf: $spaces, $n;

    my Bool $valid = check-digit( $n ) == 0;

    "Output: %s%d\n".printf:       $spaces, $valid ?? 1 !! 0;

    explain( $n, $valid ) if $VERBOSE;
}

#------------------------------------------------------------------------------
sub check-digit( UInt:D $number --> UInt:D )
#------------------------------------------------------------------------------
{
    my UInt $interim-digit = 0;

    for $number.split( '', :skip-empty ) -> Str $digit
    {
        $interim-digit = @OP-TABLE[ $interim-digit; $digit.Int ];
    }

    return $interim-digit;
}

#------------------------------------------------------------------------------
sub explain( UInt:D $n, Bool:D $valid )
#------------------------------------------------------------------------------
{
    my UInt $check-digit = $n.substr( *-1, 1 ).Int;

    qq[Explanation: The check digit "%d" is %scorrect].printf:
           $check-digit, $valid ?? '' !! 'in';

    qq[; it should be "%d"].printf:
           check-digit( $n.substr( 0, $n.chars - 1 ).Int ).Int unless $valid;

    put();
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
