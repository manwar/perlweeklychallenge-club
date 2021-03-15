#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

{
    my ( $FILE, @numbers ) = @ARGV;
    say readN( $FILE, $_ ) for @numbers;
}

sub readN ( $file, $chars ) {
    state $filehandles = {};

    my $fh;
    if ( $filehandles->{$file} ) {
        $fh = $filehandles->{$file};
    }
    else {
        open( $fh, '<', $file );
        $fh->binmode( ':utf8' );
        $filehandles->{$file} = $fh;
    }

    my $out;
    while ( $chars-- && !$fh->eof ) {
        $out .= $fh->getc;
    }

    return $out;
}
