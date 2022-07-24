use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 174
=========================

TASK #1
-------
*Disarium Numbers*

Submitted by: Mohammad S Anwar

Write a script to generate first 19 Disarium Numbers.


        A disarium number is an integer where the sum of each digit raised to
        the power of its position in the number, is equal to the number.


For example,

  518 is a disarium number as (5 ** 1) + (1 ** 2) + (8 ** 3) => 5 + 1 + 512 =>
  518

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Notes
-----
Discovery of disarium numbers [1] proceeds by testing all integers, beginning
with 1, against the given criteria. The time taken to find the first 18 dis-
arium numbers is negligible; but discovery of the 19th disarium number takes
about 254 seconds. The following strategies have been tried in order to make
subroutine is-disarium() more efficient:

    - The subroutine returns False as soon as the sum exceeds $n.
    - Higher powers are tested before lower powers: this results in a saving of
      6+ seconds.
    - Pre-computation of powers, using a look-up table, was tried, but actually
      took ~26 seconds longer than direct use of the exponentiation operator.

Reference
---------
[1] "A032799  Numbers n such that n equals the sum of its digits raised to the
     consecutive powers (1,2,3,...).", OEIS, https://oeis.org/A032799

=end comment
#==============================================================================

my UInt constant $TARGET = 19;
my Bool constant $TIMER  = False;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 174, Task #1: Disarium Numbers (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my Int $t0 = time                               if $TIMER;

    "The first $TARGET disarium numbers:\n0".print;

    my UInt $count = 1;

    loop (my UInt $n = 1; $count < $TARGET; ++$n)
    {
        if is-disarium( $n )
        {
            ", $n".print;

            ++$count;
        }
    }

    put();
    printf "\nTime: %d seconds\n", (time - $t0).Int if $TIMER;
}

#------------------------------------------------------------------------------
sub is-disarium( UInt:D $n --> Bool:D )
#------------------------------------------------------------------------------
{
    my UInt @digits = $n.split( '', :skip-empty ).map: { .Int };
    my UInt $sum    = 0;

    for (0 .. @digits.end).reverse -> UInt $i
    {
        $sum += @digits[ $i ] ** ($i + 1);

        return False if $sum > $n;
    }

    return $sum == $n;
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
