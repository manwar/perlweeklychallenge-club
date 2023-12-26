#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    [ 3, 2, 3, 2, 2, 2 ],
    [ 1, 2, 3, 4 ],
);

for my $example (@examples) {
    my $input  = join ', ', $example->@*;
    my @output = equal_pairs( $example->@* );
    my $output = join ', ',
        map { qq{($_)} } map { join ', ', $_->@* } @output;

    say <<~"END";
    Input:  \$ints = ($input)
    Output: ($output)
    END
}

sub equal_pairs (@input) {
    my @output;
    my %hash;
    for my $i (@input) {
        if ( $hash{$i} ) {
            push @output, [ $i, $i ];
            delete $hash{$i};
        }
        else {
            $hash{$i} = 1;
        }
    }
    return @output;
}
