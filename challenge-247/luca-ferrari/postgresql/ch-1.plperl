--
-- Perl Weekly Challenge 247
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-247/>
--

CREATE SCHEMA IF NOT EXISTS pwc247;

CREATE OR REPLACE FUNCTION
pwc247.task1_plperl( text[] )
RETURNS TABLE( santa text, receiver text )
AS $CODE$
   my ( $names ) = @_;

   my @santas = $names->@*;
   my @receivers = $names->@*;

   while ( @santas > 0 && @receivers > 0 ) {
      my ( $s, $r ) = ( int( rand( scalar( @santas ) ) ), int( rand( scalar( @receivers ) ) ) );
      my $santa = @santas[ $s ];
      my $receiver = @receivers[ $r ];
      next if ! $santa || ! $receiver || $santa eq $receiver;

     return_next( { santa => $santa,
       		  receiver => $receiver } );
     delete @santas[ $s ];
     delete @receiver[ $r ];
   }

   return undef;

$CODE$
LANGUAGE plperl;
