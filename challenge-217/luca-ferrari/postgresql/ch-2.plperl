--
-- Perl Weekly Challenge 217
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-217/>
--

CREATE SCHEMA IF NOT EXISTS pwc217;

CREATE OR REPLACE FUNCTION
pwc217.task2_plperl( int[] )
RETURNS int
AS $CODE$
   use List::Permutor;
   my ( $max ) = 0;
   my $engine = List::Permutor->new( $_[0]->@* );
   while ( my @current = $engine->next ) {
   	 $max = join( '', @current ) if ( join( '', @current ) > $max );
   }

   return $max;
$CODE$
LANGUAGE plperlu;
