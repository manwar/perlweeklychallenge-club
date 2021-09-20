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
  my( $r1, $r2, $str, @parts ) = ( '', '', $_[1], split //, $_[0] );
  ($r1 .= shift @parts, $r2 .= shift @parts) while @parts;
  ($r1,$r2) = map { '['.quotemeta($_).']' } $r1, $r2;
  return ( join( '', $str =~ m{$r1}g ), join( '', $str =~ m{$r2}g ));
}

