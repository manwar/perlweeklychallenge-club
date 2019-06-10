#!/usr/bin/env perl6

my $minf = 32;
my $maxf = 212;
my $minc = 0;
my $maxc = 100;

# Degrees Fahrenheit can be expressed as a function of the form f(x) = ax + C where x
# is the temperature in degrees Celsius.
# When f(x) = x, x = C / (1 - a)

say ($minf) / (1 - ($maxf - $minf) / ($maxc - $minc));
