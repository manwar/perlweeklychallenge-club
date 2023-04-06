--
-- Perl Weekly Challenge 210
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-210/>
--

CREATE SCHEMA IF NOT EXISTS pwc210;

CREATE OR REPLACE FUNCTION
pwc210.task2_plperl( int[] )
RETURNS SETOF int
AS $CODE$
  my ( $list ) = @_;
  my $move = 1;

  while ( $move ) {
     $move = 0;
     for my $index ( 0 .. scalar( $list->@* ) - 1 ) {
     	 my $offset = $list->[ $index ] > 0 ? 1 : -1;

         my ( $left, $right ) = ( $list->[ $index ], $list->[ $index + $offset ] );
	 next if ( ! $left || ! $right );
	 next if ( $left > 0 && $right > 0 );
	 next if ( $left < 0 && $right < 0 );


	 $move++;
	 $right *= ( $right < 0 ? -1 : 1 );
	 $left *= ( $left < 0 ? -1 : 1 );

	 $list->[ $index ] = 0 if ( $left <= $right );
	 $list->[ $index + $offset ] = 0 if ( $left >= $right );
     }

     $list = [ grep { $_ != 0 } $list->@* ];
  }

  for ( $list->@* ) {

      next if ( ! $_ );
      return_next( $_ );
  }

  return undef;
$CODE$
LANGUAGE plperl;
