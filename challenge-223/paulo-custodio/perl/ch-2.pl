#!/usr/bin/env perl

# Perl Weekly Challenge 223 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-223/

use Modern::Perl;

my @box = @ARGV;
my $max = 0;
collect_max(\$max, 0, @box);
say $max;

sub collect_max {
    my($max, $sum, @box) = @_;

    if (@box <= 1) {
        $sum += $box[0] if @box;
        if ($$max < $sum) {
            $$max = $sum;
        }
        return;
    }
    else {
        for my $i (0 .. $#box) {
            my $collect = collect($i, @box);
            my @new_box = (@box[0..$i-1], @box[$i+1..$#box]);
            collect_max($max, $sum+$collect, @new_box);
        }
    }
}

sub collect {
    my($i, @box) = @_;
    my $collect = 1;
    $collect *= $box[$i-1] if $i-1 >= 0;
    $collect *= $box[$i];
    $collect *= $box[$i+1] if $i+1 < @box;
    return $collect;
}
