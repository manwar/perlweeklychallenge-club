#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ min max };

my @examples = (

    [ 2, 1, 4, 5, 6, 3, 0, 2 ],
    [ 0, 5, 3, 2 ],
    [ 9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8 ],

);

for my $example (@examples) {
    my $output = order_game($example);
    my $input  = join ', ', $example->@*;
    say <<"END";
    Input:  \$ints = ($input)
    Output: $output
END
}

sub order_game ($ref) {
    my @ints = $ref->@*;
    my @output;

    while ( scalar @ints > 1 ) {
        if ( scalar @ints ) {
            my @cmp;
            push @cmp,    shift @ints;
            push @cmp,    shift @ints;
            push @output, min @cmp;
        }
        if ( scalar @ints ) {
            my @cmp;
            push @cmp,    shift @ints;
            push @cmp,    shift @ints;
            push @output, max @cmp;
        }
        if ( scalar @ints == 0  && scalar @output > 1 ) {
            @ints =  @output;
            @output = ();
        }
    }
    return shift @output;
}
