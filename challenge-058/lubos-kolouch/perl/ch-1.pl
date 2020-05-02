#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-058/
#
#  Compare two given version number strings v1 and v2 such that:
#
#    If v1 > v2 return 1
#    If v1 < v2 return -1
#    Otherwise, return 0
#
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 05/02/2020 12:57:10 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

sub compare_versions {
    my ($ver1, $ver2) = @_;

    my $v1 = version->new($ver1);
    my $v2 = version->new($ver2);

    return $v1 <=> $v2;
}

# TESTS

use Test::More;

is(compare_versions('0.1','1.1'),-1);
is(compare_versions('2.0','1.2'),1);
is(compare_versions('1.2','1.2_5'),-1);

# There is likely bug in the module, I have reported it
# https://rt.cpan.org/Ticket/Display.html?id=132482
is(compare_versions('1.2.1','1.2_1'),1);
is(compare_versions('1.2.1','1.2.1'),0);
