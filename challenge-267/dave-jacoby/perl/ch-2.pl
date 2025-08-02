#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

use List::Util qw{sum0};

my @examples = (

    {
        str    => "abcdefghijklmnopqrstuvwxyz",
        widths => [
            10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
            10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10
        ]
    },
    {
        str    => "bbbcccdddaaa",
        widths => [
            4,  10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
            10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10
        ]
    },
);

for my $example (@examples) {
    my $str    = $example->{str};
    my @widths = $example->{widths}->@*;
    my $widths = join ',', @widths;
    my @output = line_counts($example);
    my $output = join ', ', @output;

    say <<"END";
        Input:  \$str = "$str"
                \@widths = ($widths) 
        Output: ($output)
END
}

sub line_counts ($obj) {
    my $str    = $obj->{str};
    my @widths = $obj->{widths}->@*;
    my $sub    = make_weight_function(@widths);
    my $c      = 1;
    my $line   = '';
    for my $ch ( split //, $str ) {
        my $cv = $sub->($ch);
        my $lv = $sub->($line);
        if ( $lv + $cv > 100 ) { $line = ''; $lv = $sub->($line); $c++; }
        $line .= $ch;
    }
    return ( $c, $sub->($line) );
}

sub make_weight_function (@widths) {
    my @alpha = 'a' .. 'z';
    state $aw;
    $aw->%* = map { $alpha[$_] => $widths[$_] } 0 .. 25;
    return sub ($str) {
        return sum0 map { $aw->{$_} } split //, $str;
    };
    return sub ($str) { return 1 };
}

