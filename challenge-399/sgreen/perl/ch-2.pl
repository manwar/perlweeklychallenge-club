#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($path) {
    my @current_path = ();
    my $longest_path = 0;

    # Work through each line
    foreach my $line ( split( /\n/, $path ) ) {
        # Separate the leading tabs from the rest of the line.
        my ( $tabs, $file ) = ( $line =~ /^(\t*)(.*)$/ );
        my $path_pos = length($tabs);

        # Update the current path as required,
        splice( @current_path, $path_pos );
        push @current_path, $file;
        my $length = length( join( "/", @current_path ) );

        # If the file contains a dot, and is the longest, update longest_path
        if ( index( $file, "." ) != -1 and $length > $longest_path ) {
            $longest_path = $length;
        }
    }

    say $longest_path;
}

main(@ARGV);
