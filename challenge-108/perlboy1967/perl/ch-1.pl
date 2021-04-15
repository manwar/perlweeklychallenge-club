#!/usr/bin/perl

# Perl Weekly Challenge - 108
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-108/#TASK1
#
# Task 1 - Locate Memory
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use constant TEST => 1;

\TEST =~ m#SCALAR\((?<location>.*?)\)#;

printf "%s\n" , $+{location} // 'undef', 
