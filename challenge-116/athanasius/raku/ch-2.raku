use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 116
=========================

TASK #2
-------
*Sum of Squares*

Submitted by: Mohammad Meraj Zia

You are given a number $N >= 10.

Write a script to find out if the given number $N is such that sum of squares
of all digits is a perfect square. Print 1 if it is otherwise 0.

Example

 Input: $N = 34
 Output: 1 as 3^2 + 4^2 => 9 + 16 => 25 => 5^2

 Input: $N = 50
 Output: 1 as 5^2 + 0^2 => 25 + 0 => 25 => 5^2

 Input: $N = 52
 Output: 0 as 5^2 + 2^2 => 25 + 4 => 29

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Input Argument $N
-----------------
Although it is probably intended that $N be an integer, this is not explicitly
stated in the Task Description and is not really necessary. This script accepts
any real number >= 10, and includes any digits following the decimal point
along with the digits that come before. The decimal point (if any) is ignored.
For example:

    Input:  $N = 14.22
    Output: 1 as 1^2 + 4^2 + 2^2 + 2^2 = 1 + 16 + 4 + 4 = 25 = 5^2

Output
------
The required output (1 or 0) is followed by an explanation as per the Examples.
If this explanation is not wanted, the constant SHOW should be set to False.

Algorithm
---------
This is straightforward: split $N into its component digits, square each digit,
and sum the squares. The sum is itself a perfect square if and only if its
square root is an integer.

=end comment
#==============================================================================

my Bool constant SHOW = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 116, Task #2: Sum of Squares (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Real:D $N where { $N >= 10 }        #= A number greater than or equal to 10
)
#==============================================================================
{
    my Real $n       = $N + 0;       # Normalize: e.g., 010 --> 10, 0x10 --> 16

    "Input:  \$N = $n".put;

    my UInt @digits  = $n.split( '', :skip-empty ).grep( none '.' )\
                                                  .map: { .Int };
    my UInt @squares = @digits.map: { $_ * $_ };
    my UInt $sum     = 0;
            $sum    += $_ for @squares;
    my UInt $root    = perfect-square-root( $sum );

    'Output: %d'.printf: $root ?? 1 !! 0;

    if SHOW
    {
        my Str $terms   = @digits.map( { "$_^2" } ).join: ' + ';
        my Str $squares = @squares\                .join: ' + ';

        (' as ' ~ ($terms, $squares, $sum).join( ' = ' ) ~
        ($root ?? " = $root^2" !! ' which is not a perfect square')).print;
    }

    ''.put;
}

#------------------------------------------------------------------------------
sub perfect-square-root( UInt:D $N --> UInt )
#------------------------------------------------------------------------------
{
    my UInt $root = floor( $N.sqrt + 0.5 );

    # Return the square root if $N is a perfect square, or Nil otherwise

    return ($root * $root) == $N ?? $root !! Nil;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
