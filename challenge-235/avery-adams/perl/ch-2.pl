#!/usr/bin/perl
use v5.36;

my @ints = @ARGV;
for(my $i = 0; $i <= $#ints; $i++) {
    if($ints[$i] == 0) {
        splice(@ints, $i, 0, 0);
        pop(@ints);
        $i++;
    }
}

say('(', join(', ', @ints), ')');
