#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Compare;

my @examples = (

    [ [ 1, 2, 3 ], [ 2, 4, 6 ], ],
    [ [ 1, 2, 3, 3 ],
        [ 1, 1, 2, 2 ], ],

);
for my $e (@examples) {
    my @output = missing_members( $e->@* );
    my $arr1   = join ', ', $e->[0]->@*;
    my $arr2   = join ', ', $e->[1]->@*;
    my $output = join ', ',
        map { qq{[$_]} } map { join ', ', $_->@* } @output;
    say <<~"END";
    Input:  \@arr1 = ($arr1)
            \@arr2 = ($arr2)
    Output: ($output)
    END
}

sub missing_members (@input) {
    my $lc     = List::Compare->new(@input);
    my @first  = $lc->get_unique;
    my @last   = $lc->get_complement;
    my @output = grep { scalar $_->@* } ( \@first, \@last );
    return @output;
}
