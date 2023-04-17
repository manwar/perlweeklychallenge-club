--
-- Perl Weekly Challenge 213
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-213/>
--

/*
select * from pwc213.task2_plperl( 1, 7,
       	      array[
			array[1,2,3]::int[],
			array[4,5,6]::int[],
			array[3,8,9]::int[],
			array[6,7,8]::int[]
		  ]::int[][] );

*/

CREATE SCHEMA IF NOT EXISTS pwc213;

CREATE OR REPLACE FUNCTION
pwc213.task2_plperl( int, int, int[][] )
RETURNS SETOF int
AS $CODE$
  my ( $source, $destination, $routes ) = @_;
  my @path;

  push @path, $source;
  my ( $loop ) = 1;
  my ( $current_route_index ) = 0;
  while ( $loop ) {
      my ( $current_route ) = $routes->@[ $current_route_index ];

      # skip this route if there is not a match
      $current_route_index++ and next if ( ! grep( { $_ == $path[ -1 ] } $current_route->@* ) );

      for my $node ( $current_route->@* ) {
      	  push @path, $node if ( ! grep( { $node == $_ } @path ) );

	  $loop = 0;
	  
	  # search for the next route
	  for my $next_route_index ( ( $current_route_index + 1 ) .. scalar( $routes->@* ) ) {
	      next if ( ! grep( { $node == $_ } $routes->@[ $next_route_index ]->@* ) );
	      $current_route_index = $next_route_index;
	      $loop = 1;
	      last;
	  }

	  last if $loop;
      }

      last if $current_route_index > scalar( $routes->@* );
  }

  return undef if $path[ -1 ] != $destination;
  return [ @path ];
  
$CODE$
LANGUAGE plperl;
