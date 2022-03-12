#!/usr/bin/env perl
use strict;
use warnings;

{
    use List::Util qw/sum/;

    my @fibs;
    my %fib_hash;

    $fibs[0]     = 0;
    $fibs[1]     = 1;
    $fib_hash{0} = 1;
    $fib_hash{1} = 1;

    sub gen_more_fibs {

        my $new_fib = $fibs[-1] + $fibs[-2];
        push @fibs, $new_fib;
        return 1;
    }

    sub get_pisano_period {
        my $what = shift;

        my $all_nums = $fibs[0] . $fibs[1];

        my $period_len = 2;
        while (1) {
            $period_len++;
            gen_more_fibs;
            $all_nums .= $fibs[-1] % $what;

            last if $all_nums =~ /^(.*)\1$/;
        }
        return $period_len / 2;

    }
    use Test::More;
    is( get_pisano_period(3), 8 );

    done_testing;
}
