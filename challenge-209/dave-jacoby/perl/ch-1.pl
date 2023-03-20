#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    [qw{ 0 }],
    [qw{ 0 0 }],
    [qw{ 1 0 }],
    [qw{ 0 0 0 }],
    [qw{ 0 1 0 }],
    [qw{ 1 0 0 }],
    [qw{ 1 1 0 }],

    [qw{ 1 1 1 1 1 0 }],
    [qw{ 1 1 1 1 1 1 0 }],
    [qw{ 1 1 1 1 1 1 1 0 }],
    [qw{ 1 1 1 1 1 1 1 1 0 }],

);

for my $e (@examples) {
    my @bits = $e->@*;
    my $bits = join ', ', @bits;
    $bits = qq{($bits)};
    my $o = special_bit_chars(@bits);
    my $p = sbc(@bits);
    say <<"END";
    Input:  \@bits = $bits
    Output: $o
            $p
END
}

sub sbc (@array) {
    return 1 if scalar @array == 1;    #           0
    return 1 if $array[-2] == 0;       #     ... 0 0
    my $str = join '', @array;
    my ($c) = $str =~ m{(1+)0$}g;
    return ( length $c ) % 2 ? 0 : 1;
}

sub special_bit_chars (@array) {

    # 0 = a
    # 1,0 = b
    # 1,1 = c

    my $last;
    while (@array) {
        if ( $array[0] == 1 ) {
            if ( $array[1] == 1 ) {
                $last = 'C';
                shift @array;
                shift @array;
            }
            elsif ( $array[1] == 0 ) {
                $last = 'B';
                shift @array;
                shift @array;
            }
        }
        else {
            $last = 'A';
            shift @array;
        }
    }
    return $last eq 'A' ? 1 : 0;
}
