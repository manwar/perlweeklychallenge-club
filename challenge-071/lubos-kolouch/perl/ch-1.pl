#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

sub find_peaks (@arr) {
    my $n = scalar @arr;
    return [] if $n == 0;
    return [ $arr[0] ] if $n == 1;

    my @peaks;
    push @peaks, $arr[0] if $arr[0] > $arr[1];

    for my $i ( 1 .. $n - 2 ) {
        push @peaks, $arr[$i]
          if $arr[$i] > $arr[ $i - 1 ] && $arr[$i] > $arr[ $i + 1 ];
    }

    push @peaks, $arr[-1] if $arr[-1] > $arr[-2];

    return \@peaks;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is_deeply(
        find_peaks( 18, 45, 38, 25, 10, 7, 21, 6, 28, 48 ),
        [ 45, 21, 48 ],
        'Example 1'
    );
    is_deeply(
        find_peaks( 47, 11, 32, 8, 1, 9, 39, 14, 36, 23 ),
        [ 47, 32, 39, 36 ],
        'Example 2'
    );
    is_deeply( find_peaks(5), [5], 'Single element' );

    done_testing();
}
