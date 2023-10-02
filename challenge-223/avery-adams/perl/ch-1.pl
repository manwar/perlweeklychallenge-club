#!/usr/bin/perl

use strict;
use v5.24;
use Math::Prime::Util 'primes';

say scalar @{primes(shift)};
