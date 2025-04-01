#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (
    "p-er?l",
    "wee-k!L-y",
    "_c-!h_all-en!g_e",
);

for my $example (@examples) {
    my $output  = reverse_letters( $example );
    say <<"END";
    Input:  \$str = "$example"
    Output:        "$output"
END
}

sub reverse_letters ( $str ) {
    my @letters = grep {/[a-z]/mix} split //, $str;
    my @reverse = reverse( @letters ) ;
    my $i = 0 ;
    while ($i < length $str ) {
        my $l = substr( $str,$i,1);
        if ( $l eq $letters[0] ) {
            substr( $str,$i,1) = $reverse[0];
            shift @reverse;
            shift @letters;
        }
        $i++;
    }
    return $str;
}