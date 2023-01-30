--
-- Perl Weekly Challenge 202
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-202/>
--

CREATE SCHEMA IF NOT EXISTS pwc202;

CREATE OR REPLACE FUNCTION
pwc202.task2_plperl( int[] )
RETURNS int[]
AS $CODE$
  my ( $list ) = @_;
  my ( %valleys );
  my $largest = 0;

  for my $index ( 0 .. scalar( $list->@* ) - 1 ) {
     my $current = $list->[ $index ];
     next if $list->[ $index + 1 ] > $current;

     my ( @valley_left ) = ( $current );
     for ( $index + 1 .. scalar( $list->@* ) - 1 ) {
         my $previous = $valley_left[ -1 ];
     	 push( @valley_left, $list->[ $_ ] ) if ( $list->[ $_ ] <= $previous );
	 last if $list->[ $_ ] > $previous;
     }


     my @valley_right;
     if ( $index + scalar( @valley_left ) < scalar( $list->@* ) ) {
     	my $previous = $list->[ $index + scalar( @valley_left ) ];
	@valley_right = ( $previous );
	for ( $index + scalar( @valley_left ) + 1 .. scalar( $list->@* ) - 1 ) {
	    my $previous = $valley_right[ -1 ];
     	    push( @valley_right, $list->[ $_ ] ) if ( $list->[ $_ ] >= $previous );
	    last if $list->[ $_ ] < $previous;
	}
     }



     $valleys{ scalar( @valley_right ) + scalar( @valley_left ) } = [ @valley_left, @valley_right ];
     $largest = scalar( @valley_right ) + scalar( @valley_left ) if ( scalar( @valley_right ) + scalar( @valley_left ) > $largest );

  }

  return $valleys{ $largest };
$CODE$
LANGUAGE plperl;
