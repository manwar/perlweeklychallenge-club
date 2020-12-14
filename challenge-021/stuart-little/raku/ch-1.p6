#!/usr/bin/env perl6
use v6;

# run as <script> <number of decimals; defaults to 30>

use Math::BigFloat:from<Perl5>;

say Math::BigFloat.new('1').bexp((@*ARGS) ?? @*ARGS[0] !! 30).Str
