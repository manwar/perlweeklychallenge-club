#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings qw{ experimental };

use JSON;
my $json = JSON->new->space_after;

my @input = @ARGV;
@input = ( "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" )
  if !scalar @ARGV;

my @output = sup(@input);

say $json->encode( \@input );
say $json->encode( \@output );

sub sup( @words ) {
    for my $word (@words) {
        my $c = 1;
      INNER: while (1) {
            my $sub = substr( $word, 0, $c );
            my $n   = scalar grep { m{^$sub} } @words;
            if ( $n == 1 ) {
                push @output, $sub;
                last INNER;
            }
            if ( $sub eq $word ) {
                push @output, $word;
                last INNER;
            }
            $c++;
        }
    }
    return @output;
}
