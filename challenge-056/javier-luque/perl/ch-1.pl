#!/usr/bin/perl
# Test: ./ch-1.pl
use strict;
use warnings;
use feature qw /say/;

my @N = (2, 7, 9);
my $k = 2;

for (my $i = 0; $i < scalar(@N); $i++) {
    for (my $j = 0; $j < scalar(@N); $j++) {
    	next if $i == $j;
    	say "$i, $j" if ($N[$i] - $N[$j] == $k);
    }
}
