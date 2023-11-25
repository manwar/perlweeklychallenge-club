--
-- Perl Weekly Challenge 244
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-244/>
--

CREATE SCHEMA IF NOT EXISTS pwc244;

CREATE OR REPLACE FUNCTION
pwc244.task2_plperl( int[] )
RETURNS int
AS $CODE$
   use Algorithm::Combinatorics qw/ combinations /;
   use List::Util qw/ min max /;
   
   my ( $nums ) = @_;
   my $power;

   $power = 0;

   for my $k ( 1 .. $nums->@* ) {
       my $combinations = combinations( \ $nums->@*, $k );
       while ( my $iter = $combinations->next ) {
       	     $power += min( $iter->@* ) * ( max( $iter->@* ) ** 2 );
       }
   }


   return $power;
$CODE$
LANGUAGE plperlu;
