--
-- Perl Weekly Challenge 247
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-247/>
--

CREATE SCHEMA IF NOT EXISTS pwc247;

CREATE OR REPLACE FUNCTION
pwc247.task2_plperl( text )
RETURNS TABLE( needle text, repetitions int )
AS $CODE$
   my ( $string ) = @_;

   my @letters = split //, $string;
   my $score = {};
   
   for ( 0 .. @letters - 2 ) {
       my $needle = $letters[ $_ ] . $letters[ $_ + 1 ];
       my @matches = ( $string =~ / $needle /xg );
       my $count = scalar @matches;
       push $score->{ $count }->@*, $needle;
   }

   my $best = ( reverse sort keys $score->%* )[ 0 ];
   return_next( { needle => ( sort $score->{ $best }->@* )[ 0 ],
   		  repetitions => $best } );

   return undef;

$CODE$
LANGUAGE plperl;
