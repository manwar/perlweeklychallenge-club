#!perl

################################################################################
=comment

Perl Weekly Challenge 011
=========================

Challenge #1
------------

Write a script that computes the equal point in the Fahrenheit and Celsius
scales, knowing that the freezing point of water is 32 °F and 0 °C, and that the
boiling point of water is 212 °F and 100 °C. This challenge was proposed by
*Laurent Rosenfeld*.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 Perlmonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use utf8;
use Const::Fast;

const my $FAHRENHEIT_FREEZING =>  32;
const my $FAHRENHEIT_BOILING  => 212;
const my $CELSIUS_FREEZING    =>   0;
const my $CELSIUS_BOILING     => 100;

$| = 1;

MAIN:
{
    # At the equal point, degrees Fahrenheit (f) equal degrees Celsius, so
    #       f = f × ((212 - 32) / 100) + 32
    #   =>  f × (1 - 9/5) = 32
    #   =>  f = 32 / -4/5
    #         = -40.

    my $equal = $FAHRENHEIT_FREEZING /
         (1 - (($FAHRENHEIT_BOILING - $FAHRENHEIT_FREEZING) / $CELSIUS_BOILING));

    printf "\nThe equal point is %3.1f°\n", $equal;
    printf   "This is %s by conversion from Celsius to Fahrenheit\n",
              $equal == c2f($equal) ? 'confirmed' : 'refuted';
    printf   "This is %s by conversion from Fahrenheit to Celsius\n",
              $equal == f2c($equal) ? 'confirmed' : 'refuted';
}

# Convert Celsius to Fahrenheit

sub c2f
{
    my ($degrees_celsius) = @_;

    return ($degrees_celsius *
          (($FAHRENHEIT_BOILING - $FAHRENHEIT_FREEZING) / $CELSIUS_BOILING)) +
            $FAHRENHEIT_FREEZING
}

# Convert Fahrenheit to Celsius

sub f2c
{
    my ($degrees_fahrenheit) = @_;

    return ($degrees_fahrenheit - $FAHRENHEIT_FREEZING) *
           ($CELSIUS_BOILING / ($FAHRENHEIT_BOILING - $FAHRENHEIT_FREEZING));
}

################################################################################
