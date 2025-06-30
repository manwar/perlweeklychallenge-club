#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (
    qw{ WeEeekly abBAdDabc }
);

for my $input (@examples) {
    my $output = good_string($input);
    say <<"END";
    Input:  \@str = "$input"
    Output:        "$output"
END
}

sub good_string ($input) {
TOP: while (1) {
        for my $i ( 0 .. -1 + length $input ) {
            my $c = substr $input, $i, 1;
            if ( _is_uppercase($c) ) {
                my $cc = lc $c;
                if ( $cc eq substr $input, $i + 1, 1 ) {
                    substr( $input, $i + 1, 1 ) = '';
                    substr( $input, $i,     1 ) = '';
                    next TOP;
                }
            }
            else {
                my $cc = uc $c;
                if ( $cc eq substr $input, $i + 1, 1 ) {
                    substr( $input, $i + 1, 1 ) = '';
                    substr( $input, $i,     1 ) = '';
                    next TOP;
                }
            }
        }
        last;
    }
    return $input;
}
sub _is_uppercase($char) { return $char eq uc $char ? 1 : 0; }
