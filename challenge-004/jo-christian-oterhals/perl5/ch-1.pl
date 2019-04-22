#!/usr/bin/env perl

use v5.18;
use Math::BigFloat 'bpi';

say bpi(-s $ARGV[0]);
