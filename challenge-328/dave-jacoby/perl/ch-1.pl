#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (

    qw{ a?z pe?k gra?te b?a?c?d?a }
);

for my $input (@examples) {
    my $output = replace_all_Qs($input);
    say <<"END";
    Input:  \@str = "$input"
    Output:        "$output"
END
}

sub replace_all_Qs($example) {
    my @qs =
        grep { '?' eq substr( $example, $_, 1 ) } 0 .. -1 + length $example;
    for my $q (@qs) {
        for my $l ( 'A' .. 'Z' ) {
            my $ll = $l . $l;
            my $c = $example;
            substr( $c, $q, 1 ) = $l; 
            if ( $c !~ /$ll/mix ) {
                $example = $c;
                last;
            }
        }
    }
    return $example;
}

