#!/usr/bin/perl

# Challenge 011
#
# Challenge #1
# Write a script that computes the equal point in the Fahrenheit and Celsius
# scales, knowing that the freezing point of water is 32 °F and 0 °C, and that
# the boiling point of water is 212 °F and 100 °C. This challenge was proposed
# by Laurent Rosenfeld.

use strict;
use warnings;
use 5.030;

use Math::Calculus::NewtonRaphson;

my $exp = Math::Calculus::NewtonRaphson->new;

# F = (C * 9/5) + 32; F = C = x
$exp->addVariable('x');
$exp->setExpression("(x * 9/5) + 32 - x");

my $result = $exp->newtonRaphson('x', 0) or die $exp->getError;
say $result;
