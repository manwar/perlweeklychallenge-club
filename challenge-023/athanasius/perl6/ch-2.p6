use v6;

################################################################################
=begin comment

Perl Weekly Challenge 023
=========================

Task #2
-------
Create a script that prints *Prime Decomposition* of a given number. The prime
decomposition of a number is defined as a list of prime numbers which when all
multiplied together, are equal to that number. For example, the Prime decomposi-
tion of 228 is 2,2,3,19 as 228 = 2 * 2 * 3 * 19.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

BEGIN say '';

#===============================================================================
sub MAIN(UInt:D $number )                                #= Unsigned integer > 1
#===============================================================================
{
    die $*USAGE if $number <= 1;

    say "The prime decomposition of $number is: ", factor($number).join(', ');

    CATCH
    {
        default 
        {
            $*ERR.say: .message;
        }
    }
}

#-------------------------------------------------------------------------------
sub factor(UInt:D $number)
#-------------------------------------------------------------------------------
{
    my UInt $remainder = $number;
    my      @factors;

    MY-OUTER:
    for 2 .. $number -> UInt $f
    {
        if $f.is-prime
        {
            while $remainder % $f == 0
            {
                @factors.push:  $f;
                $remainder div= $f;

                last MY-OUTER if $remainder == 1;
            }
        }
    }

    die "ERROR: for number $number, remainder is $remainder"
        unless $remainder == 1;

    return @factors;
}

################################################################################

=begin note

The label used in sub factor() was originally "OUTER:". Here is the explanation
of the (cryptic!) error message that resulted:

From https://perl6.eu/colonoscopy.html

"Upper Case letters are normally used for labels, but this will cause an error
if you happen to choose a name that is already in use internally by Perl 6. The
label itself isn't a problem, as the trailing colon tells the compiler that it
is a label. The usage, where it is used as a bareword causes the problem, and
there is no way to fix it.

Some examples:

OUTER, which seems perfectly logical as a label name, will give the run time
error («Cannot resolve caller next(OUTER:U); ...»), as OUTER is a built-in
package name and Perl 6 isn't clever enough to spot that it is used as a label
in this case."

=end note
