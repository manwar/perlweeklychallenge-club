#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my ( $string, $offset ) = @_;

    # Sanity check
    die "You must enter a string\n" if not defined $string;
    die "You must enter a number\n" if not defined $offset;
    die "The string can only contain the letters A - Z and spaces\n" unless $string =~ /^[A-Z ]+$/;
    die "The value '$offset' does not look like an integer between 1 and 25\n"
      unless $offset =~ /^\d+$/
      and $offset > 0
      and $offset < 26;

    # Work out the plain text cipher
    my $plain  = join '', ( 'A' .. 'Z' );
    my $cipher = substr( $plain, -$offset ) . substr( $plain, 0, 26 - $offset );

    # Create a mapping table
    my %mapping = ( ' ' => ' ' );
    for my $i ( 0 .. 25 ) {
        $mapping{ substr( $plain, $i, 1 ) } = substr( $cipher, $i, 1 );
    }

    # Translate
    my $ciphertext = join '', map { $mapping{$_} } split //, $string;
    say $ciphertext;
}

main(@ARGV);
