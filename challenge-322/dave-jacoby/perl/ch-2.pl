#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };
use List::Util   qw{ uniq };

my @examples = ( 
    
    [ 55, 22, 44, 33 ], 
    [ 10, 10, 10 ], 
    [ 5, 1, 1, 4, 3 ], 
);

for my $example (@examples) {
    my @ints   = $example->@*;
    my $ints   = join ', ', @ints;
    my @output = rank_array( $example->@* );
    my $output = join ', ', @output;
    say <<"END";
    Input:  \@ints = ($ints)
    Output: ($output)
END
}

sub rank_array (@ints) {
    my @sorted = uniq sort { $a <=> $b } @ints;
    my %ranks;
    my $r = 1;
    for my $s (@sorted) { $ranks{$s} = $r++; }
    return map { $ranks{$_} } @ints;
}
