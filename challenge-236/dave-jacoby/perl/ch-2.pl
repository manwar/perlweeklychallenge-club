#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ uniq };

my @examples = (

    [ 4, 6, 3,  8, 15, 0, 13, 18, 7, 16, 14, 19, 17, 5, 11, 1, 12, 2, 9, 10 ],
    [ 0, 1, 13, 7, 6,  8, 10, 11, 2, 14, 16, 4, 12, 9, 17, 5, 3, 18, 15, 19 ],
    [ 9, 8, 3,  11, 5, 7, 13, 19, 12, 4, 14, 10, 18, 2, 16, 1, 0, 15, 6, 17 ],
);

for my $e (@examples) {
    my @ints   = $e->@*;
    my $ints   = join ', ', @ints;
    my $output = find_loops( \@ints );
    say <<~"END";
    Input:  \@ints = 
        ($ints)
    Output: $output
    END
}

sub find_loops ($ints) {
    my $output = 0;
    my %no_go;
    for my $i ( 0 .. -1 + scalar $ints->@* ) {
        my $v = $ints->[$i];
        next if $no_go{$v};
        my @loop = ($v);
        my $loop = traverse_loop( $ints, \@loop );
        if ( $loop == -1 ) { }
        if ( scalar $loop->@* ) {
            map { $no_go{$_} = 1 } $loop->@*;
            $output++;
        }
    }
    return $output;
}

sub traverse_loop ( $ints, $loop ) {
    my $first = $loop->[0];
    my $last  = $loop->[-1];
    my $next  = $ints->[$last];
    if ( scalar $loop->@* > scalar $ints->@* ) { return -1 }
    if ( $next == $first )                     { return $loop }
    my $copy->@* = $loop->@*;
    push $copy->@*, $next;
    return traverse_loop( $ints, $copy );
}
