#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-028/
#
#  Write a script to display Digital Clock. Feel free to be as creative as you can when displaying digits. We expect bare minimum something like “14:10:11”.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 09/30/2019 01:20:02 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;
use Acme::Cow;
use DateTime;

my $secret = shift || 0;

my $cow = new Acme::Cow;
my $dt=DateTime->now;

$cow->say($dt->hms);

# secret undocumented parameter to make the cow think!
$cow->think if $secret;
$cow->print();
