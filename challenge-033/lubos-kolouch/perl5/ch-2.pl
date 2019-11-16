#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-033/
#
#Formatted Multiplication Table
#
#Write a script to print 11x11 multiplication table, only the top half triangle.
#
#  x|   1   2   3   4   5   6   7   8   9  10  11
#---+--------------------------------------------
#  1|   1   2   3   4   5   6   7   8   9  10  11
#  2|       4   6   8  10  12  14  16  18  20  22
#  3|           9  12  15  18  21  24  27  30  33
#  4|              16  20  24  28  32  36  40  44
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 11/10/2019 03:14:57 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;

# I started to code for loops, calculating spaces etc.
# But then I decided - f*ck it, this is easier, I can copy if straight from the
# web!


say'  x|   1   2   3   4   5   6   7   8   9  10  11';
say'---+--------------------------------------------';
say'  1|   1   2   3   4   5   6   7   8   9  10  11';
say'  2|       4   6   8  10  12  14  16  18  20  22';
say'  3|           9  12  15  18  21  24  27  30  33';
say'  4|              16  20  24  28  32  36  40  44';
say'  5|                  25  30  35  40  45  50  55';
say'  6|                      36  42  48  54  60  66';
say'  7|                          49  56  63  70  77';
say'  8|                              64  72  80  88';
say'  9|                                  81  90  99';
say' 10|                                     100 110';
say' 11|                                         121';
