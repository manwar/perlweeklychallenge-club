--
-- Perl Weekly Challenge 205
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-205/>
--

CREATE SCHEMA IF NOT EXISTS pwc205;

CREATE OR REPLACE FUNCTION
pwc205.task1_plperl( int[] )
RETURNS int
AS $CODE$
  my ( $list ) = @_;
  my $values = {};
  $values->{ $_ }++ for ( sort $list->@* );
  my $offset = keys( $values->%* ) > 2 ? -3 : -1;
  return ( sort( keys( $values->%* ) ) )[ $offset ];
$CODE$
LANGUAGE plperl;
