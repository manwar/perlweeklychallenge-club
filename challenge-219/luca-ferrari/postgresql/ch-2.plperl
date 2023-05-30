--
-- Perl Weekly Challenge 219
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-219/>
--

CREATE SCHEMA IF NOT EXISTS pwc219;

CREATE OR REPLACE FUNCTION
pwc219.task2_plperl( int[], int[] )
RETURNS int
AS $CODE$
   my ( $c, $days ) = @_;
   my $costs = {};
   $costs->{ 1 }  = $c->@[ 0 ];
   $costs->{ 7 }  = $c->@[ 1 ];
   $costs->{ 30 } = $c->@[ 2 ];

   my @evaluated;
   my $current_cost = ( scalar $days->@* ) * $costs->{ 1 };
   push @evaluated, { cost => 0, days => $days };

   while ( ( scalar @evaluated ) > 0 ) {
   	 my $entry = shift @evaluated;

	 if ( $entry->{ days }->@* == 0 ) {
	    $current_cost = $entry->{ cost } if ( $entry->{ cost } < $current_cost );
	 }
	 else {
	      next if ( $entry->{ cost } >= $current_cost );

	      my $begin_date = $entry->{ days }->[ 0 ];
	      for my $duration ( keys $costs->%* ) {
	      	  my $end_date = $begin_date + $duration - 1;
		  my $cost = $entry->{ cost } + $costs->{ $duration };
		  my @remaining_days =  grep { $_ > $end_date }  $entry->{ days }->@*;
		  push @evaluated, { cost => $cost, days => \@remaining_days };
	      }	  
	 }
   }

   return $current_cost;

$CODE$
LANGUAGE plperl;
