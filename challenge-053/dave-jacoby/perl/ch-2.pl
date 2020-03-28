#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental::postderef experimental::signatures };

my $l = 2;
if ( scalar @ARGV && int $ARGV[0] > 0 ) { $l = int $ARGV[0] }

my @strings = vowel_strings($l);
say join "\n", @strings;

sub vowel_strings ( $l, $string = '' ) {
    if ( length $string == $l ) {
        return $string;
    }
    my @next;
    my $m = length $string == 0 ? '' : substr $string, -1;
    if ( $string eq '' ) {
        @next = qw{ a e i o u};
    }
    elsif ( $m eq 'a' ) {
        @next = qw{ e i };
    }
    elsif ( $m eq 'e' ) {
        @next = qw{ i };
    }
    elsif ( $m eq 'i' ) {
        @next = qw{ a o u e };
    }
    elsif ( $m eq 'o' ) {
        @next = qw{ a u };
    }
    elsif ( $m eq 'u' ) {
        @next = qw{ o e };
    }

    my @output;
    for my $n (@next) {
        push @output, vowel_strings( $l, $string . $n );
    }
    return @output;

}
