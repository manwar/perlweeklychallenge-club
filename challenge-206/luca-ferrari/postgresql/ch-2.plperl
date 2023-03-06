--
-- Perl Weekly Challenge 206
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-206/>
--

CREATE SCHEMA IF NOT EXISTS pwc206;

CREATE OR REPLACE FUNCTION
pwc206.task2_plperl( int[] )
RETURNS int
AS $CODE$
  my ( $list ) = sort $_[ 0 ];
  my $sum = 0;

  while ( $list->@* ) {
  	$sum += shift $list->@*;
	shift $list->@*;
  } 

  return $sum;
$CODE$
LANGUAGE plperl;
