#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-047/
#
#               Roman Calculator
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 02/13/2020 02:23:28 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use Roman;

sub roman_magic {
    my ($v1, $op, $v2) = @_;

    my $rom_v1 = arabic($v1);
    my $rom_v2 = arabic($v2);

    return uc(roman(eval "$rom_v1 $op $rom_v2"))
}

# TESTS

my ($v1, $op, $v2) = @ARGV;

print roman_magic($v1, $op, $v2)."\n";


use Test::More;

is (roman_magic('V','+','VI'),'XI');

done_testing;


