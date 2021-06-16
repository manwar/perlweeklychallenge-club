#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

my $translate = {
    1  => 'One',
    2  => 'Two',
    3  => 'Three',
    4  => 'Four',
    5  => 'Five',
    6  => 'Six',
    7  => 'Seven',
    8  => 'Eight',
    9  => 'Nine',
    10 => 'Ten',
    11 => 'Eleven',
    12 => 'Twelve',
    13 => 'Thirteen',
    14 => 'Fourteen',
    15 => 'Fifteen',
};

my $c = 1;
for my $i ( sort { rand 2 <=> rand 2 } 1 .. 15 ) {
    my $filename = sprintf 'text_file_%02d.txt', $c;
    open my $fh , '>', $filename;
    for my $j ( sort { rand 2 <=> rand 2 } 1 .. 15 ) {
        next if $i == $j;
        my $w = $translate->{$j};
        $w = int rand 2 ? $w : lc $w ;
        say $fh qq{$j, Line $w};
    }
    $c++;
}
