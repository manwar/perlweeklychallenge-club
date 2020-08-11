#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-036/ 
#
#               TASK #1
#               Write a program to validate given Vehicle Identification Number (VIN). For more information, please checkout wikipedia.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 11/30/2019 12:22:41 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;
use Data::Validate::VIN;


my $vin = $ARGV[0] // die 'Usage: ch-1.pl vin_code';

my $vv = Data::Validate::VIN->new($vin);

if ( $vv->valid() ) {
    say 'valid';
}
else {
    say "ERROR: $_" for @{ $vv->errors() };
}


