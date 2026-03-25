#!/usr/bin/env perl

# Perl Weekly Challenge 214 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-214/

use Modern::Perl;

sub remove_numbers {
    my(@in) = @_;
    return scalar(@in) if @in < 2;
    my $best_score = 0;
    for (my $s = 0; $s < @in; $s++) {
        my $e = $s;
        while ($e < @in && $in[$s]==$in[$e]) {
            $e++;
        }
        my @new_list = (@in[0..$s-1], @in[$e..$#in]);
        my $score = ($e-$s)*($e-$s) + remove_numbers(@new_list);
        $best_score = $score if $best_score < $score;
        $s = $e-1;
    }
    return $best_score;
}

say remove_numbers(@ARGV);
