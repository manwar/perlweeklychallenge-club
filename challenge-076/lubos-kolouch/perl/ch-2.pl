#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 2: Word Search
# Search for words in a 2D grid in all 8 directions (horizontal, vertical, diagonal, forward/backward).

sub build_search_corpus ($grid_lines) {
    return '' if !@$grid_lines;

    my @real_grid;
    for my $line (@$grid_lines) {
        my @chars = split( /\s+/, $line );
        push @real_grid, \@chars if @chars;
    }

    my $rows = scalar @real_grid;
    return '' if $rows == 0;
    my $cols = scalar @{ $real_grid[0] };

    my @strings;

    # 8 directions: (dx, dy)
    my @dirs = (
        [ 0,  1 ],     # right
        [ 1,  0 ],     # down
        [ 1,  1 ],     # down-right
        [ 1,  -1 ],    # down-left
        [ 0,  -1 ],    # left
        [ -1, 0 ],     # up
        [ -1, -1 ],    # up-left
        [ -1, 1 ],     # up-right
    );

    for my $r ( 0 .. $rows - 1 ) {
        for my $c ( 0 .. $cols - 1 ) {
            for my $d (@dirs) {
                my ( $dr, $dc ) = @$d;
                my $curr_str = '';
                my ( $cr, $cc ) = ( $r, $c );

                while ( $cr >= 0 && $cr < $rows && $cc >= 0 && $cc < $cols ) {
                    $curr_str .= $real_grid[$cr][$cc];
                    $cr += $dr;
                    $cc += $dc;
                }
                push @strings, $curr_str if length($curr_str) > 0;
            }
        }
    }

    return join( '#', @strings );
}

sub find_words ( $grid_lines, $words, $min_len = 1 ) {
    my $corpus = build_search_corpus($grid_lines);
    my @found;

    for my $word (@$words) {
        next if length($word) < $min_len;
        if ( index( $corpus, uc($word) ) != -1 ) {
            push @found, $word;
        }
    }

    return \@found;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    my @grid = (
        'B I D E',
        'H E A R',
        'C D E F',
    );

    is_deeply( find_words( \@grid, [ 'BIDE', 'HEAR', 'CDEF' ] ), [ 'BIDE', 'HEAR', 'CDEF' ], 'Horizontal words' );
    is_deeply( find_words( \@grid, ['BEE'] ),                     ['BEE'],                     'Diagonal word (B-E-E)' );
    is_deeply( find_words( \@grid, ['RAEH'] ),                    ['RAEH'],                    'Reversed word' );
    is_deeply( find_words( \@grid, ['NONEXISTENT'] ),             [],                          'Not found' );

    done_testing();
}
else {
    say "Run via embedded tests.";
}
