#!/usr/bin/perl

use strict;
use v5.10;

my @list = @ARGV;
for (my $index = 0; $index < $#list; $index++) {
    my $collision = $list[$index] + $list[$index + 1];
    if ($collision > $list[$index]) {next}
    elsif ($collision > 0) {
        splice @list, $index + 1, 1;
        $index--;
    } elsif ($collision == 0) {
        splice @list, $index, 2;
        $index--;
    } elsif (0 > $collision > $list[$index + 1]) {
        splice @list, $index, 1;
        for (my $index2 = $index - 1; $index2 >= 0 and $list[$index2] > 0; $index2--) {
            if (-$list[$index] > $list[$index2]) {
                splice @list, $index2, 1;
                $index--;
                $index2--;                
            } elsif (-$list[$index] == $list[$index2]) {
                splice @list, $index2, 2;
                $index -= 2;
            } else {
                splice @list, $index, 1;
                $index--;
            }
        }
    }
}
say $_ for @list;
