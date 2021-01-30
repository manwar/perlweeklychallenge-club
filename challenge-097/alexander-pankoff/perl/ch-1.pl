#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

{

    my $cc = Caesar::Cipher->new( 3 );
    say $cc->encrypt( 'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG' );
    say $cc->decrypt( $cc->encrypt( 'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG' ) );

}

package Caesar::Cipher {

    sub new ( $class, $rotate_count ) {
        my @alphabet = reverse( 'A' .. 'Z' );
        my @rotated = ( @alphabet[ $rotate_count .. $#alphabet ], @alphabet[ 0 .. $rotate_count ] );
        my %mapping =
          map { $alphabet[$_] => $rotated[$_] } 0 .. $#alphabet;

        return bless \%mapping, $class;
    }

    sub encrypt ( $self, $plaintext ) {
        _char_map( sub($c) { $self->{$c} // $c }, $plaintext );
    }

    sub decrypt ( $self, $ciphertext ) {
        my %reversed = reverse %$self;
        _char_map( sub($c) { $reversed{$c} // $c }, $ciphertext );
    }

    sub _char_map ( $f, $str ) {
        join( '', map { $f->( $_ ) } split( '', $str ) );
    }

}
