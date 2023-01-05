#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @examples = ( [ 1, 0, 3, 0, 0, 5 ], [ 2, 5, 8, 1 ], [3] );

for my $e (@examples) {
    my @list = $e->@*;
    my $out  = max_gap(@list);
    my $list = join ', ', @list;
    say <<"END";
    Input:  \@list = ($list)
    Output: $out
END
}

sub max_gap( @list ) {
    return 0 if scalar @list < 2;
    @list = sort @list;
    my %hash;
    for my $i ( 1 .. -1 + scalar @list ) {
        my $gap = abs $list[$i] - $list[ $i - 1 ];
        $hash{$gap}++;
    }
    my ($max) = sort { $b <=> $a } keys %hash;
    return $hash{$max};
}
