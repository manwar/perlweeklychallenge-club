#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    [ [ "ab", "c" ], [ "a",  "bc" ] ],
    [ [ "ab", "c" ], [ "ac", "b" ] ],
    [ [ "ab", "cd", "e" ], ["abcde"] ],
);

for my $e (@examples) {
    my $output = same_string( $e->@* );
    my $arr1 = join ', ', map { qq{"$_"} } $e->[0]->@*;
    my $arr2 = join ', ', map { qq{"$_"} } $e->[1]->@*;
    say <<~"END";
    Input:  \@arr1 = ($arr1)
            \@arr2 = ($arr2)
    Output: $output
    END
}

sub same_string ( @array ) {
    my ( $s1, $s2 ) = map { join '', $_->@* } @array;
    return $s1 eq $s2 ? 'true' : 'false';
}
