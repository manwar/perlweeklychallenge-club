#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ max };

my @examples = (

    [ 10, 8, 5, 4, 3 ],
    [ 25, 8, 5, 3, 3 ],
);

for my $e (@examples) {
    my $o     = h_index( $e->@* );
    my $array = join ', ', $e->@*;
    say <<"END";
    Input:  \@array = $array
    Output: $o
END
}

sub h_index ( @citations ) {
    my $max = max @citations;
    for my $h ( 1 .. $max ) {
        my $i = () = grep { $_ >= $h } @citations;
        return $h - 1 if $i < $h;
    }
    return 0;
}
