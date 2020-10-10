#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

use List::Util qw(min);

sub _is_base_string {
    my ( $string, $substring ) = @_;

    # It cannot be a base string if it does fit evenly
    return 0 if length($string) % length($substring);

    # Return true if the string is the base string repeated multiple times
    my $repeatations = length($string) / length($substring);
    return $substring x $repeatations eq $string;

}

sub main {
    my ( $string1, $string2 ) = @_;

    # Santiy check
    die "Please enter two strings\n" unless $string1 and $string2;

    # We only need to count to the minimum length
    my @base_strings = ();
    my $length       = min( length($string1), length($string2) );

    foreach my $l ( 1 .. $length ) {
        my $value = substr( $string1, 0, $l );
        push @base_strings, $value
          if _is_base_string( $string1, $value )
          and _is_base_string( $string2, $value );

    }

    say join ' ', @base_strings;
}

main(@ARGV);
