-- Perl Weekly Challenge 195
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc195;

CREATE OR REPLACE FUNCTION
pwc195.task2_plperl( int[] )
RETURNS int
AS $CODE$
   my ( $array ) = @_;
   # extract only evens
   my @evens = grep { $_ % 2 == 0 } $array->@*;
   # classify frequency
   my $bag = {};
   $bag->{ $_ }++ for ( @evens );


   # sort by frequency and value
   my @sorted_bag =
     map { $_->[1] }
     sort { $a->[0] <=> $b->[0] || $a->[1] <=> $b->[1] }
     map { [ $bag->{ $_ }, $_ ] } keys $bag->%*;


    # the first value in the list is the
    # one with the max frequency and the lowest value
    return $sorted_bag[ 0 ];	  
$CODE$
LANGUAGE plperl;
