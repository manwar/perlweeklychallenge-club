--
-- Perl Weekly Challenge 219
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-219/>
--

CREATE SCHEMA IF NOT EXISTS pwc219;

CREATE OR REPLACE FUNCTION
pwc219.task1_plperl( int[] )
RETURNS SETOF int
AS $CODE$
   my ( $n ) = @_;
   for my $value ( sort { $a <=> $b }  map { $_ * $_ } $n->@* ) {
       return_next( $value );
   }
return;   
$CODE$
LANGUAGE plperl;
