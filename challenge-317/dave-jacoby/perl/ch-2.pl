#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (

    [qw{desc dsec}],
    [qw{fuck fcuk}],
    [qw{poo eop}],
    [qw{stripe sprite}],
);

for my $example (@examples) {
    my ( $str1, $str2 ) = $example->@*;
    my $output = friendly_strings($example);
    say <<"END";
    Input:  \$str1 = "$str1",
            \$str2 = "$str2"
    Output: $output
END
}

sub friendly_strings ($example) {
    my ( $str1, $str2 ) = $example->@*;
    my $l = -1 + length $str1;
    for my $i ( 0 .. $l ) {
        for my $j ( $i + 1 .. $l ) {
            my $str1b = $str1;
            substr( $str1b, $i, 1 ) = substr( $str1, $j, 1 );
            substr( $str1b, $j, 1 ) = substr( $str1, $i, 1 );
            return 'true' if $str1b eq $str2;
        }
    }
    return 'false';
}
