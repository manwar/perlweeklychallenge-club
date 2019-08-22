use v6;

################################################################################
=begin comment

Perl Weekly Challenge 021
=========================

Task #1
-------
Write a script to calculate the value of *e*, also known as *Euler's number* and
*Napier's constant*. Please checkout wiki [ https://en.wikipedia.org/wiki/
E_(mathematical_constant) |page] for more information.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

my UInt constant $PRECISION = 50;
my UInt constant $MARGIN    =  5;      # Additional precision to ensure that the
                                       #    convergence calculations are correct

BEGIN say '';

#-------------------------------------------------------------------------------
# For the use of FatRat, see brian d foy, "As Many Digits as You Like,"
# https://www.learningperl6.com/2017/04/24/as-many-digits-as-you-like/
#-------------------------------------------------------------------------------

sub MAIN(UInt:D :$precision = $PRECISION)
{
    my FatRat $e      = FatRat.new(0, 1);
    my UInt   $target = $precision + 2 + $MARGIN;    # "+ 2" is for leading "2."
    my UInt   $n      = 0;

    while $e.Str.chars <= $target
    {
        my UInt $d = $n++ * 2;

        $e += ($d + 2).FatRat / factorial($d + 1);
    }

            --$n;
    my Str    $e-truncated = $e.substr(0 .. ($precision + 1));
              $e-truncated = $e-truncated.chop if $e-truncated.chars == 2;
    my FatRat $unit        = FatRat.new(1, 10 ** $precision);
    my Str    $e-rounded   = $e.round($unit).Str;

    say "After $n steps of the H J Brothers convergence series,\n",
        "   e = ", $e-truncated, " (truncated)\n",
        "or e = ", $e-rounded,   " (rounded)\n",
        "with a precision of $precision decimal place",
        ($precision == 1 ?? '.' !! 's.');
}

sub factorial(UInt:D $n --> UInt:D)
{
    my UInt $f  = 1;
            $f *= $_ for 2 .. $n;

    return $f;
}

################################################################################
