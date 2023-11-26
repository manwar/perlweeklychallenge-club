--
-- Perl Weekly Challenge 238
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-238/>
--

CREATE SCHEMA IF NOT EXISTS pwc238;

CREATE OR REPLACE FUNCTION
pwc238.task2_plperl( int[] )
RETURNS SETOF int
AS $CODE$
   my ( $nums ) = @_;

   my $steps = {};

   # utility function to reduce a number
   # does only one pass so that I can counter
   # how many passes are required
   my $reduce = sub {
      my ( $number ) = @_;
      return $number if ( $number <= 9 );

      my $value = 1;
      for my $digit ( split( '', $number ) ) {
       	  $value *= $digit;
      }

      return $value;      
   };

   for ( $nums->@* ) {
       my $step_counter = 0;
       my $value = $_;

       while ( $value > 9 ) {
       	     $value = $reduce->( $value );
	     $step_counter++;
       }
       
       push $steps->{ $step_counter }->@*, $_;
   }

   for my $key ( sort keys $steps->%* ) {
       return_next( $_ ) for ( sort $steps->{ $key }->@* )
   }

   return undef;
$CODE$
LANGUAGE plperl;
