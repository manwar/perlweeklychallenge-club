#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl
#
#  DESCRIPTION: Write a script for URL normalization based on rfc3986.
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
use URL::Normalize;

my $url = shift or croak 'Usage: script precision';

my $normalizer = URL::Normalize->new( $url );
$normalizer->remove_social_query_parameters;
$normalizer->make_canonical;

say "The normalized value is ".$normalizer->url; 

# No test this time, we are just using CPAN module which should be tested

