#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Carp;

# Write a script that finds the common directory path, given a collection of
# paths and directory separator. For example, if the following paths are
# supplied.

sub find_common_path {
    my ( $path_sep, $paths_ref ) = @_;
    my @common_path;

    for my $p ( @{$paths_ref} ) {
        my @split_p = split /$path_sep/, $p;
        unless (@common_path) {
            @common_path = @split_p;
            next;
        }

        if ( @split_p < @common_path ) {
            @common_path = @common_path[ 0 .. @split_p - 1 ];
        }

        for my $i ( 0 .. @common_path - 1 ) {

            # Stop processing this path as soon as we encounter
            # a directory not seen before
            if ( $split_p[$i] ne $common_path[$i] ) {

                # Save only the so-far shared path.
                # The array will always have one element
                # thanks to the fact that the first separator
                # is also the first character.
                @common_path = @common_path[ 0 .. $i - 1 ];
                last;
            }
        }

        return ('') if ( @common_path == 1 && $common_path[0] eq '' );
    }

    return @common_path;
}

my @path_list = qw(/a/b/c/d
    /a/b/cd
    /a/b/cc
    /a/b/c/d/e);

my $path_sep = "/";
my @common_path = find_common_path( $path_sep, \@path_list );

say "Common path is: '", join( $path_sep, @common_path ), "'";
