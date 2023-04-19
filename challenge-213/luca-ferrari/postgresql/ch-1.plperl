--
-- Perl Weekly Challenge 213
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-213/>
--

CREATE SCHEMA IF NOT EXISTS pwc213;

CREATE OR REPLACE FUNCTION
pwc213.task1_plperl( int[] )
RETURNS int[]
AS $CODE$
   my ( $array ) = @_;
   my @sorted;
   @sorted = ( sort( grep( { $_ % 2 == 0 } $array->@* ) ),
               sort(  grep( { $_ % 2 != 0 } $array->@* ) ) );
   return [ @sorted ];
$CODE$
LANGUAGE plperl;
