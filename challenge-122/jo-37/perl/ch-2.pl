#!/usr/bin/perl

use v5.16;
use warnings;
use Math::Prime::Util 'forcomp';

# The task is to list all compositions of N where each part is limited
# to p <= 3.

forcomp {say "@_"} $ARGV[0], {amax => 3};
