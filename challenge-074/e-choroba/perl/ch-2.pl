#! /usr/bin/perl
use warnings;
use strict;

sub fnr_character {
    my ($s) = @_;
    my $r;
    my %count;
    my @order;
    for my $i (0 .. length($s) - 1) {
        my $ch = substr $s, $i, 1;
        my $first;
        if (1 == ++$count{$ch}) {
            unshift @order, $first = $ch;
        } else {
            $first = '#';
            for my $o (@order) {
                $first = $o, last if 1 == $count{$o};
            }
        }
        $r .= $first;
    }
    return $r
}

use Test::More tests => 2;

is fnr_character('ababc'),  'abb#c',  'example 1';
is fnr_character('xyzzyx'), 'xyzyx#', 'example 2';
