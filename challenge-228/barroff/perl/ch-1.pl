#!/usr/bin/env perl

use v5.38;

sub unique_sum (@ints) {
    use List::Util qw( uniq sum );
    my %int_hash;
    map( { $int_hash{$_}++ } @ints );
    sum( grep { $int_hash{$_} == 1 } keys %int_hash ) or 0;
}

sub MAIN() {
    if (@ARGV) {

        #| Run command line arguments
        say unique_sum(@ARGV);
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 3;

        is unique_sum( 2, 1, 3, 2 ), 4,  'works for (2, 1, 3, 2)';
        is unique_sum( 1, 1, 1, 1 ), 0,  'works for (1, 1, 1, 1)';
        is unique_sum( 2, 1, 3, 4 ), 10, 'works for (2, 1, 3, 4)';
    }
}

MAIN();
