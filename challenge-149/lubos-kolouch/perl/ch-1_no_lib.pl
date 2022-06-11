#!/usr/bin/env perl

use strict;
use warnings;
use List::Util qw/sum/;

my @fibs;
my %fib_hash;

$fibs[0] = 0;
$fibs[1] = 1;
$fib_hash{0} = 1;
$fib_hash{1} = 1;

sub gen_more_fibs {
    my $limit = shift;

    while ($fibs[-1] < $limit) {
        my $new_fib =$fibs[-1] + $fibs[-2];
        push @fibs,  $new_fib;
        $fib_hash{$new_fib} = 1;
    }

}

sub get_numbers {
    my $what = shift;

    my $count = 0;
    my $pos = 0;

    my @output;

    while($count < $what) {
        gen_more_fibs($pos);
        if ($fib_hash{sum(split //, $pos)}) {
            push @output, $pos;
            $count++;
        }
        $pos++;

    }
    
    return \@output;
}

use Test::More;

is_deeply(get_numbers(20), [0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44]);
done_testing;
