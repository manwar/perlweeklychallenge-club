--
-- Perl Weekly Challenge 209
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-209/>
--

CREATE SCHEMA IF NOT EXISTS pwc209;

CREATE OR REPLACE FUNCTION
pwc209.task1_plperl( text )
RETURNS int
AS $CODE$
  my ( $string ) = @_;
  my @bits = split( '', $string );
  return 1 if ( @bits % 2 != 0 && @bits[ - 1 ] == 0 );
  return 1 if ( @bits % 2 == 0 && @bits[ - 1 ] == 0 && @bits[ - 2 ] == 0 );
  return 0;
$CODE$
LANGUAGE plperl;
