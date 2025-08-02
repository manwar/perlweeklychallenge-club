#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ sum0 };
use JSON;
my $j = JSON->new->pretty;

my @examples = ( 1, 3, 4, 5, 7 );
for my $input (@examples) {
    my $o      = unique_sum_zero($input);
    my $output = join ', ', $o->@*;

    say <<~"END";
    Input:  \$matrix = $input
    Output: ($output)
    END
}

sub unique_sum_zero ( $input, $list = [] ) {
    return [0] if $input == 1;             # handle zero case
    if ( $input == scalar $list->@* ) {    # control recursion
        return $list if 0 == sum0 $list->@*;
        return -1;
    }
    my $c = 0;
    while (1) {
        my @list = $list->@*;
        my $n = -9 + int rand 19;           # generates a number between -9 and 9
        next if grep { $_ == $n } @list;    # removes duplicates
        push @list, $n;
        my $return = unique_sum_zero( $input, \@list );
        if ( ref $return && ref $return eq 'ARRAY' ) {
            return $return;
        }

        # if you have bad numbers, it'll be hard to recover
        # so we'll give up after a while
        return -1 if $c++ > 100;
    }
    return -1;
}
