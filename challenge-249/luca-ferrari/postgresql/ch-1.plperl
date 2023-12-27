--
-- Perl Weekly Challenge 249
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-249/>
--

CREATE SCHEMA IF NOT EXISTS pwc249;

CREATE OR REPLACE FUNCTION
pwc249.task1_plperl( int[] )
RETURNS SETOF int[]
AS $CODE$

   my ( $nums ) = @_;

   my $classification = {};

   $classification->{ $_ }++ for ( $nums->@* );

   for ( sort keys $classification->%* ) {
       my $how_many_pairs = $classification->{ $_ } / 2;
       next if $how_many_pairs < 1;

       return_next( [ $_, $_ ] ) while ( $how_many_pairs-- >= 1 );
       
   }

return undef;
$CODE$
LANGUAGE plperl;
