#!/usr/bin/perl

use strict;
use warnings;
use 5.10.1;

sub main (@) {
    my ( $string, $count, $offset ) = @_;

    # Sanity checks
    my $length = length $string;
    die "A string must be supplied\n" unless $string;
    die "The count must be a postive integer\n"
      unless $count =~ /^[0-9]+$/ and $count >= 1;
    die "The offset must be a postive integer\n"
      unless $offset =~ /^[0-9]+$/ and $offset >= 1;
    die "The count + offset must be less than the length of the string\n"
      unless $count + $offset < $length;

    for my $i ( 1 .. $count ) {
        ( substr( $string, $i, 1 ), substr( $string, $i + $offset, 1 ) ) =
          ( substr( $string, $i + $offset, 1 ), substr( $string, $i, 1 ) );
    }

    say $string;
}

main(@ARGV);
