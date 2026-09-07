#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

sub gray_code_sequence ($n) {
    return [0] if $n <= 0;

    my @gray_code = ( '0', '1' );

    for my $i ( 2 .. $n ) {
        my @rev_gray_code = reverse @gray_code;
        @gray_code     = map { "0$_" } @gray_code;
        @rev_gray_code = map { "1$_" } @rev_gray_code;
        push @gray_code, @rev_gray_code;
    }

    my @decimals = map { oct("0b$_") } @gray_code;
    return \@decimals;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is_deeply(
        gray_code_sequence(4),
        [ 0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8 ],
        'Example N=4'
    );
    is_deeply(
        gray_code_sequence(3),
        [ 0, 1, 3, 2, 6, 7, 5, 4 ],
        'Example N=3'
    );
    is_deeply( gray_code_sequence(1), [ 0, 1 ], 'Example N=1' );

    done_testing();
}
