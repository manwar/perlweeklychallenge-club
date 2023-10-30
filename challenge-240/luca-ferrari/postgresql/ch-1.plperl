--
-- Perl Weekly Challenge 240
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-240/>
--

CREATE SCHEMA IF NOT EXISTS pwc240;

CREATE OR REPLACE FUNCTION
pwc240.task1_plperl( text, text[] )
RETURNS boolean
AS $CODE$
  my ( $check, $strings ) = @_;
  my @check_letters = map { $_ } split( //, $check );
  my @letters = map {  ( split //, $_  )[ 0 ] } $strings->@*;

  return 0 if ( @check_letters != @letters );

  for ( 0 .. @check_letters ) {
      return 0 if ( CORE::fc( $check_letters[ $_ ] ) ne CORE::fc( $letters[ $_ ] ) );
  }

  return 1;
$CODE$
LANGUAGE plperl;
