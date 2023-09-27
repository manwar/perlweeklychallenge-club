#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::MoreUtils qw( first_index );
use List::Util      qw( sum0 );

my @examples = (

    [ 5, 5, 5,  10, 20 ],
    [ 5, 5, 10, 10, 20 ],
    [ 5, 5, 5,  20 ],
);

for my $e (@examples) {
    my @ints   = $e->@*;
    my $ints   = join ', ', @ints;
    my $output = exact_change(@ints) ? 'true' : 'false';
    say <<~"END";
    Input:  \@ints = ($ints)
    Output: $output
    END
}

sub exact_change (@transactions) {
    my @till;
    my $till = 0;
T: for my $t (@transactions) {
        my $change = $t - 5;
        $till += 5;
        push @till, $t;
        if ($change) {
            my @bills = has_change( $change, \@till, [] );
            my $bills = sum0 @bills;
            return 0 if $change != $bills;
            for my $b (@bills) {
                my $fi = first_index { $_ == $b } @till;
                delete $till[$fi];
                @till = grep { defined } @till;
            }
        }
    }
    return 1;
}

sub has_change ( $change, $till, $values = [] ) {
    my @till = sort { $b <=> $a } $till->@*;    # sort big to small, big bills first
    my $sum  = sum0 $values->@*;
    return             if $sum > $change;   # too much change
    return             if !scalar @till;    # not enough in till
    return $values->@* if $sum == $change;  # exactly right
    for my $i ( 0 .. -1 + scalar @till ) {  # 
        my @copy = $values->@*;
        my $v    = shift @till;
        push @copy, $v;
        my @out = has_change( $change, \@till, \@copy );
        my $val = sum0 @out;
        return @out if $val == $change;
        push @till, $v;
    }
    return;
}
