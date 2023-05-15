--
-- Perl Weekly Challenge 215
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-215/>
--

CREATE SCHEMA IF NOT EXISTS pwc215;

CREATE OR REPLACE FUNCTION
pwc215.task1_plperl( text[] )
RETURNS SETOF text
AS $CODE$
  my ( $words ) = @_;
  for ( $words->@* ) {
      return_next( $_ ) if ( $_ eq join( '', sort( split( //, $_ ) ) ) );
  }

return undef;
$CODE$
LANGUAGE plperl;
