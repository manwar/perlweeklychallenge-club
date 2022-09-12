-- Perl Weekly Challenge 182
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc182;

CREATE OR REPLACE FUNCTION
pwc182.task2_plperl( text[] )
RETURNS text
AS $CODE$

   my @common_path = ( '/' );
   my $current_piece;
   my $index = 0;
   my $min_index = 99;

   while ( $index < $min_index ) {
       my @current_pieces = split( '/', @{ $_[0] }[ 0 ] );
       $min_index = $#current_pieces if ( $#current_pieces < $min_index );

       my $found = 1;
       for my $current_dir ( @{ $_[0] } ) {
           my @pieces = split( '/', $current_dir );
           $min_index = $#pieces if ( $#pieces < $min_index );
           $found = 0 if ( $pieces[ $index ] != $current_pieces[ $index ] );
       }

       push @common_path, $current_pieces[ $index ] if ( $found && $current_pieces[ $index ] );
       last if ( ! $found );
       $index++;
   }

   return join( '/', @common_path );
   
$CODE$
LANGUAGE plperl;
