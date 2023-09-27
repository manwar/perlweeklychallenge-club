--
-- Perl Weekly Challenge 236
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-236/>
--

CREATE SCHEMA IF NOT EXISTS pwc236;

CREATE OR REPLACE FUNCTION
pwc236.task2_plperl( int[] )
RETURNS int
AS $CODE$
   my ( $nums ) = @_;
   my @loops;
   
   for my $current_start ( 0 .. $nums->@* ) {
       my @current_path = ();

       push @current_path, $nums->[ $current_start ];
       my $next = $nums->[ $current_start ];

       while ( 0 < $next < scalar( $nums->@* ) ) {
       	     push @current_path, $nums->[ $next ];

	     if ( $nums->[ $next ] == $current_start ) {
	     	push @loops, \@current_path;
		last;
	     }

	     $next = $nums->[ $next ];
       }
   }


   return scalar @loops;
$CODE$
LANGUAGE plperl;
