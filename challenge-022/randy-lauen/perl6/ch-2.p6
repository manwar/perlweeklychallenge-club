#!/usr/bin/env perl6

=begin SYNOPSIS

Task:
Write a script to implement Lempel–Ziv–Welch (LZW) compression algorithm.
The script should have method to encode/decode algorithm.

This script is a port of my Perl5 solution, which itself was a port of LZW-B at
https://marknelson.us/posts/2011/11/08/lzw-revisited.html.

Usage:
    $ perl6 ch-2.p6 --encode file.txt > file.txt.encoded
    $ perl6 ch-2.p6 --decode file.txt.encoded > file.txt.decoded

=end SYNOPSIS

use P5pack;

constant $MAX-CODE = 32767;

multi MAIN( Str $file where *.IO.r, Bool :$encode! ) {
    encode( $file );
}

multi MAIN( Str $file where *.IO.r, Bool :$decode! ) {
    decode( $file );
}

sub encode( Str $file ) {
    my $fh = $file.IO.open( :bin );

    my %codes = (^256).map: { .chr => $_ };
    my $next-code = 256;
    my $current-buffer = Buf.new;

    while my $buf = $fh.read( 1 ) {
        $current-buffer.append: $buf;
        if  %codes{ $current-buffer.decode('latin1') }:!exists {
            if $next-code <= $MAX-CODE {
                %codes{ $current-buffer.decode('latin1') } = $next-code++;
            }
            $current-buffer.pop();

            my $bytes = pack( 'S', %codes{ $current-buffer.decode('latin1') } );
            $*OUT.write( $bytes );
            $current-buffer = $buf;
        }
    }

    if ( $current-buffer.bytes ) {
        my $bytes = pack( 'S', %codes{ $current-buffer.decode('latin1') } );
        $*OUT.write( $bytes );
    }

    $fh.close;

    return;
}


sub decode( Str $file ) {
    my $fh = $file.IO.open( :bin );

    my %strings = (^256).map: { $_ => Buf.new( $_ ) };
    my $previous = Buf.new;
    my $next-code = 256;

    while my $buf = $fh.read( 2 ) {
        my $code = unpack( 'S', $buf );

        if %strings{ $code }:!exists {
            %strings{ $code } = Buf.new( $previous.list.flat, $previous[0] );
        }
        $*OUT.write( %strings{ $code } );
        if ( $previous.bytes && $next-code <= $MAX-CODE ) {
            %strings{ $next-code++ } = Buf.new( $previous.list.flat, %strings{ $code }[0] );
        }
        $previous = Buf.new( %strings{ $code } );
    }

    $fh.close;

    return;
}


