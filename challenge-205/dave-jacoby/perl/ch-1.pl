#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ uniq max };

my @examples = (

    [ 5, 3, 4 ],
    [ 5, 6 ],
    [ 5, 4, 4, 3 ],
);

for my $e (@examples) {
    my $list = join ',', $e->@*;
    my $out  = third_highest( $e->@* );
    say <<"END";
    Input:  \@array = ($list)
    Output: $out
END
}

sub third_highest ( @array ) {
    @array = uniq sort { $b <=> $a } @array;
    return max @array if scalar @array < 3;
    return $array[2];
}
