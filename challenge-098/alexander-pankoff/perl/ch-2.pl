#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(first);

{
    my @N = @ARGV;
    my $N = pop @N;

    say join( " ", '@N:', @N );
    say join( " ", '$N:', $N );
    my ( $index, @new_N ) = search_insert_position( $N, @N );

    my $human_index = $index + 1;

    say @new_N == @N
      ? "$human_index since the target $N is in the array at the index $human_index."
      : "$human_index since the target $N is missing and should be placed at the index $human_index."
}

sub search_insert_position ( $target, @xs ) {
    my $index = first_index( sub($x) { $x >= $target }, @xs );

    if ( !$index ) {
        return ( $#xs + 1, @xs, $target );
    }
    elsif ( $xs[$index] && $xs[$index] == $target ) {
        return ( $index, @xs );
    }
    else {
        return ( $index, @xs[ 0 .. $index - 1 ], $target, @xs[ $index .. $#xs ] );
    }
}

sub first_index ( $cond, @xs ) {
    first { $cond->( $xs[$_] ) } 0 .. $#xs;
}
