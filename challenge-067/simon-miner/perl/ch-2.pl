#!/usr/local/bin/perl

use strict;
use warnings;

my @letters = (
    ['+'],    # Need some way to track 0 to avoid colliding strings.
    [ '_', ',', '@' ],
    [qw( A B C )],
    [qw( D E F )],
    [qw( G H I )],
    [qw( J K L )],
    [qw( M N O )],
    [qw( P Q R S )],
    [qw( T U V )],
    [qw( W X Y Z )],
);

my $S = shift( @ARGV );
die "Stringcan only contain digits 0-9" if $S =~ m/[\D]/;

my @letter_strings = get_letter_strings( $S );
print join( "\n", @letter_strings ) . "\n";

sub get_letter_strings {
    my ( $S ) = @_;
    return () unless $S;

    $S =~ s/^(\d)// && ( my $digit = $1 );

    my @letter_strings = ();
    my @letters        = @{ $letters[$digit] };
    if ( $S ) {
        for my $letter ( @letters ) {
            for my $letter_string ( get_letter_strings( $S ) ) {
                push( @letter_strings, $letter . $letter_string );
            }
        }
    }
    else {
        @letter_strings = @letters;
    }

    return @letter_strings;
}
