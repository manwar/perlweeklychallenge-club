#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my @tests = ( [1, 2, 3, 6, 7, 8, 9],
              [11, 12, 14, 17, 18, 19],
              [2, 4, 6, 8],
              [1, 2, 3, 4, 5]
            );
for my $test (@tests) {
    my @input = @$test;
    my $prev = shift @input;
    my @result;
    my @tmp_res = ($prev);
    for my $i (@input) {
        if ($i == $prev + 1) {
            push @tmp_res, $i;
        } else {
            push @result, [@tmp_res];
            @tmp_res = ($i);
        }
        $prev = $i;
        # say "tmp ",  @tmp-res;
    }
    push @result, [@tmp_res];
    say "( ", (map "[@$_] ", @result), ")";
}
