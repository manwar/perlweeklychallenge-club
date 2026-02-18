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

    my ( $nums1, $seps1 ) = _parse_version($ver1);
    my ( $nums2, $seps2 ) = _parse_version($ver2);

    my $min = @$nums1 < @$nums2 ? scalar(@$nums1) : scalar(@$nums2);
    for my $i ( 0 .. $min - 1 ) {
        return -1 if $nums1->[$i] < $nums2->[$i];
        return 1  if $nums1->[$i] > $nums2->[$i];

        next if $i == 0;

        my $s1 = $seps1->[ $i - 1 ];
        my $s2 = $seps2->[ $i - 1 ];
        next if $s1 eq $s2;

        return 1  if $s1 eq '.';
        return -1;
    }

    return -1 if @$nums1 < @$nums2;
    return 1  if @$nums1 > @$nums2;
    return 0;
}

sub _parse_version {
    my ($ver) = @_;

    die "Invalid version string\n" if $ver !~ /\A[0-9._]+\z/;

    my @nums = ($ver =~ /(\d+)/g);
    my @seps = ($ver =~ /([._])\d+/g);
    return ( \@nums, \@seps );
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

done_testing;
