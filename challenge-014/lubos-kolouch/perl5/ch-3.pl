#!/usr/bin/perl
#===============================================================================
#
#         FILE: ch-3.pl
#
#        USAGE: ./ch-3.pl
#
#  DESCRIPTION: Perl Weekly Challenge Week 14 # 3
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-014/
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 06/24/2019 12:43:09 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw /say/;
use WWW::Mechanize;

my $city = shift // die 'No city ID passed';

my $mech = WWW::Mechanize->new;

$mech->get( 'http://geodb-free-service.wirefreethought.com/v1/geo/cities/' . $city . '/time' );

my $result = $mech->content or die 'No content could be fetched';

$result =~ s/.*\"\:\"//msxg;
$result =~ s/\"\}//msxg;

say "It is now $result";
