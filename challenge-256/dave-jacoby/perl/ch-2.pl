#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    [ "abcd",   "1234" ],
    [ "abc",    "12345" ],
    [ "abcde",  "123" ],
);

for my $example (@examples) {
    my $output = merge_strings( $example->@* );
    my $p      = $example->[0];
    my $w      = $example->[1];

    say <<~"END";
    Input:  \$str1 = "$p", \$str2 = "$w"
    Output: "$output"
    END
}

sub merge_strings ( $str1, $str2 ) {
    my $output;
    while ( length $str1 && length $str2 ) {
        $output .= substr( $str1, 0, 1 ) .  substr( $str2, 0, 1 );
        substr( $str1, 0, 1 ) = '';
        substr( $str2, 0, 1 ) = '';
    }
    return $output . $str1 . $str2;
}
