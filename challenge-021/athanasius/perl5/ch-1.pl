#!perl

################################################################################
=comment

Perl Weekly Challenge 021
=========================

Task #1
-------
Write a script to calculate the value of *e*, also known as *Euler's number* and
*Napier's constant*. Please checkout wiki [ https://en.wikipedia.org/wiki/
E_(mathematical_constant) |page] for more information.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use bignum;
use Const::Fast;
use Getopt::Long;

const my $PRECISION => 50;
const my $USAGE     => "USAGE: perl $0 [--precision <UInt>]\n";

BEGIN
{
    print "\n";
}

MAIN:
{
    my $precision = $PRECISION;

    GetOptions
    (
        'precision=i' => \$precision,

    ) or die $USAGE;

    $precision >= 0
        or die "Invalid precision \"$precision\"\n$USAGE";

    my $accuracy = $precision + 3;

    Math::BigFloat->accuracy($accuracy);

    my $e_prev = Math::BigFloat->bone('-');;
    my $e_next = Math::BigFloat->bzero;
    my $n      = 0;

    while ($e_prev->blt($e_next))
    {
        $e_prev = $e_next->copy;
        my $d   = $n++ * 2;
        $e_next->badd( ($d + 2) / factorial($d + 1) );
    }

     --$n;
       $accuracy   -= 2;
    my $e_truncated = $e_next->copy->bround($accuracy, 'trunc');
    my $e_rounded   = $e_next->copy->bround($accuracy, 'even');

    print "After $n steps of the H J Brothers convergence series,\n",
          "   e = ", $e_truncated, " (truncated)\n",
          "or e = ", $e_rounded,   " (rounded)\n",
          "with a precision of $precision decimal place",
          ($precision == 1 ? '' : 's'), ".\n";
}

sub factorial
{
    my ($n) = @_;
    my  $f  = 1;
        $f *= $_ for 2 .. $n;

    return $f;
}

################################################################################

__END__

The H J Brothers convergence series:

e = Sum[n = 0 .. Inf] ( (2n + 2) / (2n + 1)! )

References:

-- https://www.intmath.com/exponential-logarithmic-functions/calculating-e.php
-- http://www.brotherstechnology.com/docs/icnsae_(cmj0104-300dpi).pdf
