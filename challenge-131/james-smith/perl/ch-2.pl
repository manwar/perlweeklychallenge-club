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
  ## Initilize variables
  ## && Split delimeters on ""...
  my( $r1, $r2, $str, @parts ) = ( '', '', $_[1], split //, $_[0] );

  ## Merge 1st, 3rd, ... character into r1 & 2nd, 4th ... into r2
  ( $r1 .= shift @parts, $r2 .= shift @parts ) while @parts;

  ## Convert to regex - making sure we escape special chars
  ## Return result of regex matches...
  return map { join '', $str =~m{$_}g    }
         map { '(['.quotemeta( $_ ).'])' }
         $r1, $r2;
}

