#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say state);

# Prevent 'Wide character in say' warnings
use open ':std', ':encoding(UTF-8)';

sub readN {
    my ( $filename, $length ) = @_;
    state $fh = {};

    # Map the file name to a file handle if not already done
    if ( not exists $fh->{$filename} ) {
        open( $fh->{$filename}, "<:encoding(UTF-8)", $filename )
          || die "Can't open UTF-8 encoded $filename: $!";
    }

    # Read $length characters into $output and display it
    my $output = '';
    read( $fh->{$filename}, $output, $length );
    say $output;
}

sub main {
    my ( $file, @lengths ) = @_;
    foreach my $length (@lengths) {
        readN( $file, $length );
    }
}

main(@ARGV);
