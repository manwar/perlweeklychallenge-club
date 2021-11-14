use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 135
=========================

TASK #2
-------
*Validate SEDOL*

Submitted by: Mohammad S Anwar

You are given 7-characters alphanumeric SEDOL.

Write a script to validate the given SEDOL. Print 1 if it is a valid SEDOL
otherwise 0.

For more information about SEDOL, please checkout the
[ https://en.wikipedia.org/wiki/SEDOL |wikipedia] page.

Example 1

  Input: $SEDOL = '2936921'
  Output: 1

Example 2

  Input: $SEDOL = '1234567'
  Output: 0

Example 3

  Input: $SEDOL = 'B0YBKL9'
  Output: 1

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 135, Task #2: Validate SEDOL (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Str:D   $SEDOL,                    #= 7-character alphanumeric SEDOL string
    Bool:D :$verbose = False           #= Print annotated output?
)
#==============================================================================
{
    "Input:  \$SEDOL = '$SEDOL'".put;

    my Bool $valid   = False;
    my Str  $message = '';

    if (my UInt $length = $SEDOL.chars) == 7
    {
        my Str $code = $SEDOL.substr: 0, 6;

        ($valid, $message) = validate-code( $code );

        if $valid
        {
            my Str $check = $SEDOL.substr: 6, 1;

            ($valid, $message) = validate-check-digit( $code, $check );
        }
    }
    else
    {
        $message = "Invalid number of characters: found $length, must be 7";
    }

    "Output: %d%s\n".printf: $valid   ?? 1 !! 0,
                             $verbose ?? " ($message)" !! '';
}

#------------------------------------------------------------------------------
sub validate-code
(
    Str:D $code where $code.chars == 6,
--> Array:D[Bool:D, Str:D]
)
#------------------------------------------------------------------------------
{
    my Bool $valid   = True;
    my Str  $message = '';

    for 0 .. 5 -> UInt $i
    {
        my Str $char = $code.substr: $i, 1;

        if $char !~~ / <[0..9] + [A..Z] - [AEIOU]> /
        {
            $valid   = False;
            $message = "Invalid code character '$char'";
            last;
        }
    }

    return [$valid, $message];
}

#------------------------------------------------------------------------------
sub validate-check-digit
(
    Str:D $code  where $code\.chars == 6,
    Str:D $check where $check.chars == 1
--> Array:D[Bool:D, Str:D]
)
#------------------------------------------------------------------------------
{
    my Bool $valid   = False;
    my Str  $message = '';

    if $check ~~ / <[0..9]> /
    {
        my UInt $check-digit = get-check-digit( $code );

        if $check.Int == $check-digit
        {
            $valid   = True;
            $message = 'The check digit is correct';
        }
        else
        {
            $message = "Incorrect check digit: found '$check', should be " ~
                       "'$check-digit'";
        }
    }
    else
    {
        $message = "Invalid check digit '$check'";
    }

    return [$valid, $message];
}

#------------------------------------------------------------------------------
sub get-check-digit
(
    Str:D $code where $code.chars == 6
--> UInt:D
)
#------------------------------------------------------------------------------
{
    my UInt @weighting    = 1, 3, 1, 7, 3, 9, 1;
    my UInt $weighted-sum = 0;

    for 0 .. 5 -> UInt $i
    {
        my Str  $char  = $code.substr: $i, 1;
        my UInt $value = $char ~~ / <[0..9]> / ?? $char.Int
                                               !! 10 + $char.ord - 'A'.ord;

        $weighted-sum += $value * @weighting[ $i ];
    }

    return (10 - ($weighted-sum % 10)) % 10;
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
