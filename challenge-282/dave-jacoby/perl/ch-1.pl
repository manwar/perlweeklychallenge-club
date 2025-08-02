#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ postderef say signatures state };

use List::Util qw{ uniq };

my @examples = ( 12344456, 1233334, 10020003 );

for my $example (@examples) {
    my $output = good_integer($example);
    say <<"END";
    Input:  \@int = $example
    Output: $output
END
}

sub good_integer ($input) {
    my $good  = '';
    my @input = split //, $input;
    my $len   = -1 + length $input;
OUTER: for my $i ( 0 .. $len ) {
        if ( $i > 0 && $input[$i] eq $input[ $i - 1 ] ) {
            next;
        }
        for my $j ( 1 .. $len ) {
            my $k = $i + $j;
            next if $k > $len;
            my @split  = @input[ $i .. $k ];
            my @digits = uniq sort @split;
            next OUTER if scalar @digits > 1;
            $good = join '', @split if scalar @split > 2;
        }
    }
    return qq{"$good"} if length $good == 3;
    return -1;
}
