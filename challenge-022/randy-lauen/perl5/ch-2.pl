#!/usr/bin/env perl

# Task:
# Write a script to implement Lempel–Ziv–Welch (LZW) compression algorithm. 
# The script should have method to encode/decode algorithm.

# This is a port of LZW-B found at https://marknelson.us/posts/2011/11/08/lzw-revisited.html

use strict;
use warnings;
use feature 'say';

encode( $ARGV[0] );

sub encode {
    my $file = shift;

    open my $in, '<', $file or die $!;
    open my $out, '>', "$file.lzw" or die $!;

    my %codes = map { chr($_) => $_ } 0 .. 255;
    my $next_code = 256;
    my $current_string = '';

    while ( my $line = <$in> ) {
        foreach my $char ( split //, $line ) {
            $current_string .= $char;
            if ( !exists $codes{ $current_string } ) {
                $codes{ $current_string } = $next_code++;
                $current_string = substr( $current_string, 0, -1 );
                print $out pack( 'S', $codes{ $current_string} );
                $current_string = $char;
            }
        }
    }

    if ( length $current_string ) {
        print $out pack( 'S', $codes{ $current_string} );
    }

    close $in;
    close $out;

    return;
}

