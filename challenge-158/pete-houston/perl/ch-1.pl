#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 15801.pl
#
#        USAGE: ./15801.pl  
#
#  DESCRIPTION: Output all Additive Primes <= 100
#
# REQUIREMENTS: List::Util, Math::Prime::Util
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 28/03/22
#===============================================================================

use strict;
use warnings;
use feature 'say';

use List::Util qw/sum/;
use Math::Prime::Util qw/is_prime primes/;

say join ', ', grep { is_prime (sum split //) } @{primes (100)};
