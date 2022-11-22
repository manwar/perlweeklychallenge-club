-- Perl Weekly Challenge 192
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc192;

CREATE OR REPLACE FUNCTION
pwc192.task2_plperl( int[] )
RETURNS int
AS $CODE$
   my @moves;
   my ($array) = @_;
   
   # utility function to get the
   # max value from the array
   my $find_max = sub {
      my $max = 0;
      for ( @_ ) {
        elog(INFO, "value $_" );
        $max = $_ if $_ > $max;
      }

      return $max;
  };

  # utility function to get the sum of the array
  my $sum_array = sub {
     my $sum = 0;
     $sum += $_ for ( @_ );
     return $sum;
  };

  my $item = $sum_array->( $array->@* ) / scalar( $array->@* );
  return -1 if ( $item != int($item) );

  push @moves, $array;

  while ( scalar( grep( { $_ == $item } $array->@* ) ) != scalar( $array->@* ) ) {
         my $max = $find_max->( $array->@* );
  	for my $index ( 0 .. scalar $array->@* ) {
	    next if $array->[ $index ] != $max;

	    for my $borrow ( 0 .. scalar $array->@* ) {
	    	next if $borrow == $index;
		next if $array->[ $borrow ] >= $array->[ $index ];
		next if $array->[ $borrow ] >= $item;
		$array->[ $borrow ]++;
		last;
	    }

	    $array->[ $index ]--;
	}

	push @moves, $array;
  }

  return scalar @moves;
$CODE$
LANGUAGE plperl;
