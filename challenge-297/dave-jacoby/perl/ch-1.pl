#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (

    [ 1, 0 ],
    [ 0, 1, 0 ],
    [ 0, 0, 0, 0, 0 ],
    [ 0, 1, 0, 0, 1, 0 ],
);

for my $example (@examples) {
    my $input  = join ', ', $example->@*;
    my $output = continuous_array($example);

    say <<"END";
    Input:  \@binary = ($input)
    Output: $output
END
}

sub continuous_array ($array) {
    my $l   = 0;
    my $max = -1 + scalar $array->@*;
    for my $i ( 0 .. $max ) {
        for my $j ( $i + 1 .. $max ) {
            my @local = map { $array->[$_] } $i .. $j;
            my $len   = 1 + ( $j - $i );
            my $z     = just_zero(@local);
            my $o     = just_one(@local);
            next unless $z == $o;
            if ( $len > $l ) { $l = $len; }
        }
    }
    return $l;
}

sub just_zero (@array) {
    return scalar grep { $_ == 0 } @array;
}

sub just_one (@array) {
    return scalar grep { $_ == 1 } @array;
}
