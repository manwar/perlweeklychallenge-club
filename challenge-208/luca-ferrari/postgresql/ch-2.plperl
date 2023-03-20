--
-- Perl Weekly Challenge 208
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-208/>
--

CREATE SCHEMA IF NOT EXISTS pwc208;

/*
testdb=> select pwc208.task2_plperl( array[ 1,2,2,4,5]::int[] );
       task2_plperl       
--------------------------
 (2,"Duplicated value 2")
 (3,"Missing value 3")
(2 rows)

*/
CREATE OR REPLACE FUNCTION
pwc208.task2_plperl( int[] )
RETURNS TABLE( v int, d text )
AS $CODE$
  my ( $list ) = @_;
  my %results;

  my ( $min, $max ) = ( sort $list->@* )[0, -1];
  for my $needle ( $min .. $max ) {
      $results{ $needle } += scalar grep { $_ == $needle } $list->@*;
  }

  for ( sort keys %results ) {
    next if $results{ $_ } == 1;
    return_next( { v => $_, d => "Missing value $_" } ) if ( $results{ $_ } == 0 );
    return_next( { v => $_, d => "Duplicated value $_" } ) if ( $results{ $_ } > 1 );
  }

return undef;
 
$CODE$
LANGUAGE plperl;
