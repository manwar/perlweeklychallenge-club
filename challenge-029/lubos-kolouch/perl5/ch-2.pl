#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-029/
#
#  Write a script to demonstrate calling a C function. It could be any user defined or standard C function.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 10/12/2019 07:55:51 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;

use Inline C => << 'END';

void print_c() {
    printf("test");
}

END

print_c;


