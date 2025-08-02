#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    {
        items1 => [ [ 1, 1 ], [ 2, 1 ], [ 3, 2 ] ],
        items2 => [ [ 2, 2 ], [ 1, 3 ] ],
    },
    {
        items1 => [ [ 1, 2 ], [ 2, 3 ], [ 1, 3 ], [ 3, 2 ] ],
        items2 => [ [ 3, 1 ], [ 1, 3 ] ],
    },
    {
        items1 => [ [ 1, 1 ], [ 2, 2 ], [ 3, 3 ] ],
        items2 => [ [ 2, 3 ], [ 2, 4 ] ],
    }
);

for my $example (@examples) {
    my @output = merge_items($example);
    my $output = join ', ', map { make_block($_) } @output;
    my $items1 = join ', ', map { make_block($_) } $example->{items1}->@*;
    my $items2 = join ', ', map { make_block($_) } $example->{items2}->@*;

    say <<"END";
    Input: \@items1 = [ $items1 ]
           \@items2 = [ $items2 ]
    Output: [ $output ]
END
}

sub make_block ($ref) {
    my $list =  join ',', $ref->@*;
    return qq{[$list]};
}

sub merge_items ($example) {
    my %output;
    for my $p ( $example->{items1}->@*, $example->{items2}->@* ) {
        my ( $item_id, $quantity ) = $p->@*;
        $output{$item_id} += $quantity;
    }
    return map { [ int $_, $output{$_} ] } sort keys %output;
}
