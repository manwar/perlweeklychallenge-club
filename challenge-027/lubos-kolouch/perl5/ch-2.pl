#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-027/
#
#
#
#    Write a script that allows you to capture/display historical data. It could be an object or a scalar. For example
#
#        my $x = 10; $x = 20; $x -= 5;
#
#
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 09/28/2019 02:48:06 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use Data::Dumper;

my $what = 'my $x = 10; $x = 20; $x -= 5';
my @history;

my $x;
for (split /;/msx, $what) {
    push @history, eval || die 'error in expression';
}

warn Dumper \@history;
