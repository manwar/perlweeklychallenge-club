#!/usr/bin/env perl

=head1 SYNOPSIS

Task:
Write a script to implement Lempel–Ziv–Welch (LZW) compression algorithm. 
The script should have method to encode/decode algorithm.

This is a port of LZW-B found at https://marknelson.us/posts/2011/11/08/lzw-revisited.html.
See C<test-lzw.pl> for how to test this program.

=cut

use strict;
use warnings;
use feature 'say';

use Getopt::Long;

use constant MAX_CODE => 32767;

my $encode;
my $decode;

GetOptions(
    'encode' => \$encode,
    'decode' => \$decode,
) or die "GetOptions failed";

die "Must specify either --encode or --decode" unless $encode xor $decode;

encode( $ARGV[0] ) if $encode;
decode( $ARGV[0] ) if $decode;

exit 0;


sub encode {
    my $file = shift;

    open my $fh, '<:raw', $file or die $!;

    my %codes = map { chr($_) => $_ } 0 .. 255;
    my $next_code = 256;
    my $current_string = '';

    my $char;
    while ( read($fh, $char, 1)  ) {
        $current_string .= $char;
        if ( !exists $codes{ $current_string } ) {
            if ( $next_code <= MAX_CODE ) {
                $codes{ $current_string } = $next_code++;
            }
            $current_string = substr( $current_string, 0, -1 );
            print pack( 'S<', $codes{ $current_string } );
            $current_string = $char;
        }
    }

    if ( length $current_string ) {
        print pack( 'S<', $codes{ $current_string} );
    }

    close $fh;

    return;
}


sub decode {
    my $file = shift;

    open my $fh, '<:raw', $file or die $!;

    my %strings = map { $_ => chr($_) } 0 .. 255;
    my $previous_string = '';
    my $next_code = 256;

    my $code;
    while ( read($fh, $code, 2)  ) {
        $code = unpack( 'S<', $code );
        if ( !exists $strings{ $code } ) {
            $strings{ $code } = $previous_string . substr($previous_string, 0, 1);
        }
        print $strings{ $code };
        if ( length $previous_string && $next_code <= MAX_CODE ) {
            $strings{ $next_code++ } = $previous_string . substr( $strings{ $code }, 0, 1 );
        }
        $previous_string = $strings{ $code };
    }

    close $fh;

    return;
}



