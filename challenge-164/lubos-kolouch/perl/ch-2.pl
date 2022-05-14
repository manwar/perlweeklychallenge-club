package main;
use strict;
use warnings;

sub is_happy {
    my $what = shift;

    my %results_cache;

    while (1) {
        my $result = 0;
        for my $num ( split //, $what ) {
            $result += $num * $num;
        }

        return 1 if $result == 1;
        return 0 if $results_cache{$result};
        $results_cache{$result} = 1;
        $what = $result;
    }

    return;
}

sub get_happy_numbers {
    my $what = shift;

    my @output;

    my $pos = 1;
    while ( scalar @output < 8 ) {
        push @output, $pos if is_happy($pos);
        $pos += 1;
    }

    return \@output;

}

use Test::More;

is_deeply( get_happy_numbers(), [ 1, 7, 10, 13, 19, 23, 28, 31 ] );

done_testing;
1;
