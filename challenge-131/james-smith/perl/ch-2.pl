#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [ '""[]()', '"I like (parens) and the Apple ][+" they said.' ], [ '"(["','")]"' ] ],
  [ [ '**//<>', '/* This is a comment (in some languages) */ <could be a tag>' ], [ '/**/<','/**/>' ] ],
);


is( join( ' - ', find_pairs( @{$_->[0]})), join( ' - ', @{$_->[1]} ) ) foreach @TESTS;

done_testing();

sub find_pairs {
  return map { join '', $_[1] =~m{$_}g   }
         map { '(['.quotemeta( $_ ).'])' }
         map { join '', $_[0] =~ /$_/g   }
         qr((.).), qr(.(.));
}

