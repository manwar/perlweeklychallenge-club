#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @examples = (

    [ 1, 2, 3, 1, 1, 3 ],
    [ 1, 2, 3 ],
    [ 1, 1, 1, 1 ],

);

for my $e (@examples) {
    my @list = $e->@*;
    my $out  = good_pairs(@list);
    my $list = join ',', @list;
    say <<"END";
    Input:  \@list = ($list)
    Output: $out
END
}

sub good_pairs ( @list ) {
    my $out = 0;
    my $max = -1 + scalar @list;
    for my $i ( 0 .. $max ) {
        for my $j ( $i + 1 .. $max ) {
            $out++ if $list[$i] == $list[$j];
        }
    }
    return $out;
}
