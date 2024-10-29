#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ first max };

my @examples = (

    [ [ 1, 3 ], [ 3, 1 ], [ 2, 4 ], [ 6, 8 ] ],
    [ [ 1, 2 ], [ 2, 1 ], [ 1, 1 ], [ 1, 2 ], [ 2, 2 ] ],
);

for my $example (@examples) {
    my $output = similar_dominos( $example->@* );
    my $input  = join ', ', map { qq{[$_]} }
        map { join ', ', $_->@* } $example->@*;
    say <<"END";
    Input:  \$ints = ($input)
    Output: $output
END
}

sub similar_dominos (@dominos) {
    my %hash;
    map { $hash{$_}++ }
        map { join ',', $_->@* }
        map {
        [ sort { $a <=> $b } $_->@* ]
        } @dominos;
    my @values =
        map  { $hash{$_} }
        sort { $hash{$b} <=> $hash{$a} }
        keys %hash;
    return shift @values;
}
