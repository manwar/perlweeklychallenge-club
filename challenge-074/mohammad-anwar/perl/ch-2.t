#!/usr/bin/perl

#
# Perl Weekly Challenge - 074
#
# Task #2: FNR Character
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-074
#

package FNRCharacter;

use Moo;

sub fnr_character {
    my ($self, $string) = @_;

    my @fnr = ();
    foreach my $i (0 .. length($string) - 1) {
        my $s = substr($string, 0, $i + 1);
        if (length($s) == 1) {
            push @fnr, $s;
        }
        else {
            my $found = 0;
            my %count = ();

            $count{$_}++ for split //, $s;
            foreach (split //, reverse $s) {
                if ($count{$_} == 1) {
                    push @fnr, $_;
                    $found = 1;
                    last;
                }
            }
            push @fnr, '#' unless ($found);
        }
    }

    return join '',@fnr;
}

package main;

use strict;
use warnings;

use Test2::V0 -target => 'FNRCharacter';

isa_ok($CLASS, 'FNRCharacter');
can_ok($CLASS, 'fnr_character');
is($CLASS->fnr_character('ababc'),  'abb#c',  'example 1');
is($CLASS->fnr_character('xyzzyx'), 'xyzyx#', 'example 2');

done_testing;
