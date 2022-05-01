use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 162
=========================

TASK #1
-------
*ISBN-13*

Submitted by: Mohammad S Anwar

Write a script to generate the check digit of given ISBN-13 code. Please refer
[ https://en.wikipedia.org/wiki/International_Standard_Book_Number#ISBN-13_
check_digit_calculation |wikipedia] for more information.

Example

  ISBN-13 check digit for '978-0-306-40615-7' is 7.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Note
----
The following are accepted as input:

 - A 13-digit ISBN code
 - A 12-digit ISBN code, optionally followed by a question mark to indicate the
   unknown check digit
 - A 10-digit ISBN code, which will be converted to its 13-digit equivalent.
   This must include a check digit, but it will not be checked for correctness.

All forms may contain separators (spaces or hyphens). No checks are made for
the correctness of separator placement.

=end comment
#==============================================================================

subset ISBN-char of Str where * ~~ / ^ <[ - \h 0 .. 9 ]> ** 10..17 $ /;

my Bool constant $VERBOSE = False;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 162, Task #1: ISBN-13 (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| 10-, 12-, or 13-digit ISBN code (may contain separators)

    Str:D $code where { $code ~~ / ^ <[- \h 0 .. 9 ]>+ $ / &&
                        10 <= $code.chars <= 17 }
)
#==============================================================================
{
    my Str $code-val = validate-code( $code );

    "Input:  $code".put;

    my Str  $digits = S:g/ <-[\d]> // given $code-val;
    my UInt @digits = $digits.split( '', :skip-empty ).map: { .Int };

    +@digits == 12 or die "ERROR: @digits contains { +@digits } characters";

    loop (my UInt $i = 1; $i < +@digits; $i += 2)
    {
        @digits[ $i ] *= 3;
    }

    my UInt $sum   = [+] @digits;
    my UInt $r     = 10 - ($sum % 10);
    my UInt $check = $r < 10 ?? $r !! 0;

    $code-val ~~ s/ \? $ //;                              # Remove trailing '?'
    $code-val ~= '-' unless $code ~~ / \- $ /;            # Add trailing hyphen

    "Output: ISBN-13 check digit for '%s' is %d\n".printf:
        $code ~ $check, $check;
}

#------------------------------------------------------------------------------
sub validate-code( Str:D $orig-code --> Str:D )
#------------------------------------------------------------------------------
{
    my Str $code = $orig-code;

    $code ~~ s:g/ <[- \h ]> //;                # Remove separators     (if any)
    $code ~~ s/ \? $ //;                       # Remove a trailing '?' (if any)
    $code ~~ / (<-[ 0 .. 9 ]>) /               # Look for illegal characters
            and error( qq[Invalid input character "$1"] );

    my UInt $len = $code.chars;

    $code = $orig-code;                        # Restore original separators

    if    $len == 10
    {
        $code = '978-' ~ $code;
        $code.= chop: 1;                       # Remove trailing check digit
    }
    elsif $len == 13
    {
        $code.= chop: 1;                       # Remove trailing check digit
    }
    elsif $len != 12                           # Missing check digit is allowed
    {                                          # for ISBN-13 (not for ISBN-10)
        error( 'Invalid length' );
    }

    return $code;
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

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
