#!/usr/bin/perl

#
# Perl Weekly Challenge - 074
#
# Task #1: Majority Element
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-074
#

package MajorityElement;

use Moo;
use POSIX qw(floor);

sub find_majority_element {
    my ($self, $list) = @_;

    die "ERROR: Missing list.\n"         unless defined $list;
    die "ERROR: Invalid list [$list].\n" unless (ref($list) eq 'ARRAY');

    print "List: ", join(", ", @$list), "\n";
    my $mid_point = floor(($#$list + 1) / 2);
    my %elements  = ();
    $elements{$_}++ foreach (@$list);

    my $top = (sort { $elements{$b} <=> $elements{$a} }
               keys %elements)[0];

    ($elements{$top} >= $mid_point)
    ?
    (return $top)
    :
    (return -1);
}

package main;

use strict;
use warnings;

use Test2::V0 -target => 'MajorityElement';

can_ok($CLASS, 'find_majority_element');
isa_ok($CLASS, 'MajorityElement');
is($CLASS->find_majority_element([1, 2, 2, 3, 2, 4, 2]),  2, 'example 1');
is($CLASS->find_majority_element([1, 3, 1, 2, 4, 5]),    -1, 'example 2');

done_testing;
