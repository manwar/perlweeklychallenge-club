#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 082
#               http://www.perlweeklychallenge.org
#               Task 2 - Interleave String
#               
#       AUTHOR: Lubos Kolouch 
#      CREATED: 10/16/2020 07:25:23 PM
#===============================================================================

use strict;
use warnings;
use 5.022;

sub InterLeave {

	my ($params) = @_;

	my $result = $params->{'result'} // {};
	my $a = $params->{'a'};
	my $b = $params->{'b'};
	my $current = $params->{'current'} // '';

	if (not $a and not $b) {
        $result->{$current} = 1;
        return $result;
    }

    $result = InterLeave({'a' => substr($a, 1), 'b' => $b, 'current' => $current.substr($a,0,1), 'result' => $result }) if length($a);
    $result = InterLeave({'b' => substr($b, 1), 'a' => $a, 'current' => $current.substr($b,0,1), 'result' => $result }) if length($b);

    return $result;
}

sub can_interleave {
    my ($params) = @_;

    return 0 unless length($params->{'a'}) + length($params->{'b'}) == length($params->{'c'});

    my $result = InterLeave($params);

    return defined $$result{$params->{'c'}}? 1: 0;
}

use Test::More;

is_deeply(can_interleave( { 'a' => 'XY', 'b' => 'X', c => 'XXY' } ), 1);
is_deeply(can_interleave( { 'a' => 'XXY', 'b' => 'XXZ', c => 'XXXXZY' } ), 1);
is_deeply(can_interleave( { 'a' => 'YX', 'b' => 'X', c => 'XXY' } ), 0);
is_deeply(can_interleave( { 'a' => 'XXY', 'b' => 'X', c => 'XXY' } ), 0);

done_testing;
