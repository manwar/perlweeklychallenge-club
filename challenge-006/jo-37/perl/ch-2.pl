#!/usr/bin/perl

use v5.16;
use warnings;
use Math::BigFloat;

say Math::BigFloat->bexp(
    Math::BigFloat->bpi->bmul(Math::BigFloat->new(163)->bsqrt)
);
