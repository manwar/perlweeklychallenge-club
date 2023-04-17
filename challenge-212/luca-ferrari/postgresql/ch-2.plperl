--
-- Perl Weekly Challenge 212
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-212/>
--

CREATE SCHEMA IF NOT EXISTS pwc212;

CREATE OR REPLACE FUNCTION
pwc212.task2_plperl( int[], int )
RETURNS SETOF int[]
AS $CODE$
   my ( $list, $size ) = @_;
   return undef if ( scalar( $list->@* ) % $size != 0 );

   my $bag = {};
   $bag->{ $_ }++ for ( $list->@* );

   my $find_min_available = sub {
      my ( $bag, $array ) = @_;
      for my $k ( sort keys $bag->%* ) {
      	  if ( $bag->{ $k } > 0 && ! grep( {$_ == $k} $array->@* ) ) {
	     $bag->{ $k } -= 1;
	     return $k;
	  }
      }
   };

   my $done = 0;

   while ( $done < ( $list->@* / $size ) ) {
       my $current = [];
       while ( scalar( $current->@* ) != $size ) {
       	     my $value = $find_min_available->( $bag, $current );
	     return undef if ! $value;
	     push $current->@*, $value;
       }

      return_next( $current );
      $done++;
   }

return undef;
$CODE$
LANGUAGE plperl;
