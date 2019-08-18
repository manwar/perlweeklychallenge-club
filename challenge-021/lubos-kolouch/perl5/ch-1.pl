#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl
#
#  DESCRIPTION: Write a script to calculate the value of e, also known as Euler’s number and Napier’s constant. Please checkout wiki page for more information.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 08/17/2019 03:46:57 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw{ say };
use Carp;
use Math::Big qw{ euler };

my $precision = shift or croak 'Usage: script precision';

croak 'Usage: script precision - Precision must be an integer > 0' unless $precision =~ /^\d+$/msx;

say "The value of e for precision $precision is " . euler( 1, $precision );

# No test this time, we are just using CPAN module which should be tested

