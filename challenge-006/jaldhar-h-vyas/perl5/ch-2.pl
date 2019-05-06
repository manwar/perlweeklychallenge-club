#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use Math::BigFloat;

printf "%.33s\n",Math::BigFloat->new(1)->bexp **
    (Math::BigFloat->bpi * Math::BigFloat->new(163)->bsqrt);
