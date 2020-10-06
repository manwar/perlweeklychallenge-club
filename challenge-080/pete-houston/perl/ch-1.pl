#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 8001.pl
#
#        USAGE: ./8001.pl N ... 
#
#  DESCRIPTION: Print the smallest missing positive int from the
#               argument list
#
# REQUIREMENTS: Params::Util
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 28/09/20
#===============================================================================

use strict;
use warnings;
use Params::Util '_POSINT';

# Build the hash from only the positive integers
my %pos;
$pos{$_} = 1 for grep { _POSINT ($_) } @ARGV;

# Find the lowest missing value
my $lowest = 1;
$lowest++ while $pos{$lowest};
print "$lowest\n";
